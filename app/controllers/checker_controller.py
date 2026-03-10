from flask import request, jsonify
from app.model.checker.insert_comment_db import (
    insert_collection_comment_db,
    insert_disbursement_comment_db,
    insert_dfur_comment_db,
)
from app.model.general.activity_logs import insert_activity_logs_db

# Reserved/non-actual usernames that should fall back to default
SYSTEM_USERNAMES = {"system", "System", "SYSTEM", None, ""}

# inserting activity logs helper
def log_activity(user_id, username, action, module, description):
    resolved_user_id = user_id if user_id is not None else 5
    resolved_username = username if username not in SYSTEM_USERNAMES else "bookkeeper"
    insert_activity_logs_db(
        resolved_user_id,
        {
            "username": resolved_username,
            "action": action,
            "module": module,
            "description": description,
            "ip_address": request.remote_addr,
            "user_agent": request.headers.get("User-Agent")
        }
    )

def insert_flag_comment_controller():
    ...
    try:
        ...
        data = request.get_json()
        reviewed_by = data['reviewed_by']
        comment = data['comment']
        flag_type = data['flag_type']
        
        if flag_type == 'collection':
            collection_id = data['collection_id']
            if insert_collection_comment_db(collection_id, reviewed_by, comment):
                log_activity(data.get('user_id'), data.get('username'), "INSERT", "Collection Management", f"A review comment has been successfully submitted for Collection record (ID: {collection_id}).")
                return jsonify({'message': 'Comment inserted successfully'}), 200
            else:
                log_activity(data.get('user_id'), data.get('username'), "INSERT_FAILED", "Collection Management", f"Review comment submission failed for Collection record (ID: {collection_id}). The operation could not be completed. Please try again or contact the system administrator.")
                return jsonify({'message': 'Failed to insert comment'}), 500
        elif flag_type == 'disbursement':
            disbursement_id = data['disbursement_id']
            if insert_disbursement_comment_db(disbursement_id, reviewed_by, comment):
                log_activity(data.get('user_id'), data.get('username'), "INSERT", "Disbursement Management", f"A review comment has been successfully submitted for Disbursement record (ID: {disbursement_id}).")
                return jsonify({'message': 'Comment inserted successfully'}), 200
            else:
                log_activity(data.get('user_id'), data.get('username'), "INSERT_FAILED", "Disbursement Management", f"Review comment submission failed for Disbursement record (ID: {disbursement_id}). The operation could not be completed. Please try again or contact the system administrator.")
                return jsonify({'message': 'Failed to insert comment'}), 500
        elif flag_type == 'dfur':
            dfur_id = data['dfur_id']
            if insert_dfur_comment_db(dfur_id, reviewed_by, comment):
                log_activity(data.get('user_id'), data.get('username'), "INSERT", "DFUR Project Management", f"A review comment has been successfully submitted for DFUR project record (ID: {dfur_id}).")
                return jsonify({'message': 'Comment inserted successfully'}), 200
            else:
                log_activity(data.get('user_id'), data.get('username'), "INSERT_FAILED", "DFUR Project Management", f"Review comment submission failed for DFUR project record (ID: {dfur_id}). The operation could not be completed. Please try again or contact the system administrator.")
                return jsonify({'message': 'Failed to insert comment'}), 500
        else:
            log_activity(data.get('user_id'), data.get('username'), "INSERT_FAILED", "Flag Comment Management", f"Review comment submission failed. The specified flag type '{flag_type}' is not recognized. Please provide a valid flag type and try again.")
            return jsonify({'message': 'Invalid flag type'}), 400
    
    except Exception as e:
        return jsonify({'message': str(e)}), 500