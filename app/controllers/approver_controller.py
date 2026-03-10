from flask import request, jsonify
from app.model.approver.insert_approval_db import (
    put_collection_approval_db,
    put_disbursement_approval_db,
    put_dfur_approval_db
)
from app.model.general.activity_logs import insert_activity_logs_db

# Reserved/non-actual usernames that should fall back to default
SYSTEM_USERNAMES = {"system", "System", "SYSTEM", None, ""}

# inserting activity logs helper
def log_activity(user_id, username, action, module, description):
    resolved_user_id = user_id if user_id is not None else 7
    resolved_username = username if username not in SYSTEM_USERNAMES else "approver"
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

def approver_controller():
    ...
    try:
        ...
        data = request.get_json()
        approval_type = data.get('approval_type')
        review_status = data.get('review_status')
        
        if approval_type == 'collection':
            collection_id = data.get('collection_id')
            approval = put_collection_approval_db(collection_id, review_status)
            if approval:
                log_activity(data.get('user_id'), data.get('username'), "APPROVAL", "Collection Management", f"Collection record approval status has been successfully updated to '{review_status}'.")
                return jsonify({'message': 'Collection approval updated successfully'}), 200
            else:
                log_activity(data.get('user_id'), data.get('username'), "APPROVAL_FAILED", "Collection Management", f"Collection record approval update failed. The operation could not be completed. Please verify the record ID and try again.")
                return jsonify({'message': 'Failed to update collection approval'}), 400
        elif approval_type == 'disbursement':
            disbursement_id = data.get('disbursement_id')
            approval = put_disbursement_approval_db(disbursement_id, review_status)
            if approval:
                log_activity(data.get('user_id'), data.get('username'), "APPROVAL", "Disbursement Management", f"Disbursement record approval status has been successfully updated to '{review_status}'.")
                return jsonify({'message': 'Disbursement approval updated successfully'}), 200
            else:
                log_activity(data.get('user_id'), data.get('username'), "APPROVAL_FAILED", "Disbursement Management", f"Disbursement record approval update failed. The operation could not be completed. Please verify the record ID and try again.")
                return jsonify({'message': 'Failed to update disbursement approval'}), 400
        elif approval_type == 'dfur':
            dfur_id = data.get('dfur_id')
            approval = put_dfur_approval_db(dfur_id, review_status)
            if approval:
                log_activity(data.get('user_id'), data.get('username'), "APPROVAL", "DFUR Project Management", f"DFUR project record approval status has been successfully updated to '{review_status}'.")
                return jsonify({'message': 'DFUR approval updated successfully'}), 200
            else:
                log_activity(data.get('user_id'), data.get('username'), "APPROVAL_FAILED", "DFUR Project Management", f"DFUR project record approval update failed. The operation could not be completed. Please verify the record ID and try again.")
                return jsonify({'message': 'Failed to update DFUR approval'}), 400
        else:
            log_activity(data.get('user_id'), data.get('username'), "APPROVAL_FAILED", "Approval Management", f"Approval request failed. The specified approval type '{approval_type}' is not recognized. Please provide a valid approval type and try again.")
            return jsonify({'error': 'Invalid approval type'}), 400
    except Exception as e:
        return jsonify({'error': str(e)}), 500