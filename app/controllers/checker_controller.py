from flask import request, jsonify
from app.model.checker.insert_comment_db import (
    insert_flag_comment_db,
    put_flagged_db,
)
from app.model.checker.get_comment_db import get_flag_comments_db
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

# this both can use of checker and approver
def insert_flag_comment_controller():
    try:
        data = request.get_json()
        comment    = data['comment']
        username   = data['username']
        flagged_by = data['flagged_by']
        flag_type  = data['flag_type']

        TYPE_CONFIG = {
            'collection':   ('collection_id',  'collection_id',  'Collection Management',   'Collection'),
            'disbursement': ('disbursement_id', 'disbursement_id','Disbursement Management', 'Disbursement'),
            'dfur':         ('dfur_id',         'dfur_project_id','DFUR Project Management', 'DFUR Project'),
        }

        if flag_type not in TYPE_CONFIG:
            log_activity(data.get('user_id'), username, "INSERT_FAILED", "Flag Comment Management",
                         f"Review comment submission failed. The flag type '{flag_type}' is not recognized.")
            return jsonify({'message': 'Invalid flag type'}), 400

        data_key, db_kwarg, module, label = TYPE_CONFIG[flag_type]
        record_id = data[data_key]

        # Step 1: Mark the record as flagged
        flag_success = put_flagged_db(flag_type, record_id)

        # Step 2: Insert the comment into flag_comments
        comment_success = insert_flag_comment_db(
            flagged_by=flagged_by,
            username=username,
            comment=comment,
            **{db_kwarg: record_id}
        )

        if flag_success and comment_success:
            log_activity(data.get('user_id'), username, "INSERT", module,
                         f"A review comment has been successfully submitted for {label} record (ID: {record_id}).")
            return jsonify({'message': 'Comment inserted successfully'}), 200
        else:
            log_activity(data.get('user_id'), username, "INSERT_FAILED", module,
                         f"Review comment submission failed for {label} record (ID: {record_id}). Please try again or contact the system administrator.")
            return jsonify({'message': 'Failed to insert comment'}), 500

    except Exception as e:
        return jsonify({'message': str(e)}), 500
    
def get_flag_comments_controller(flag_type, record_id):
    try:
        if not flag_type or not record_id:
            return jsonify({'message': 'flag_type and record_id are required'}), 400

        result = get_flag_comments_db(flag_type, record_id)

        if result is None:
            return jsonify({'message': 'Invalid flag type or failed to fetch comments'}), 400

        return jsonify({'data': result}), 200

    except Exception as e:
        return jsonify({'message': str(e)}), 500