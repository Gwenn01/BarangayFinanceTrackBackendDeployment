import pandas as pd
import numpy as np
import os
from datetime import datetime
from werkzeug.utils import secure_filename
from flask import request, jsonify

from app.model.encoder.budget_entries_db import (
    insert_budget_entries_db,
    insert_budget_entries_bulk_db,
    get_budget_entries_db,
    put_budget_entries_db,
    delete_budget_entries_db,
)
from app.model.encoder.collections_db import (
    insert_collection_db,
    insert_collection_bulk_db,
    get_collection_db,
    put_collection_db,
    delete_collection_db,
    get_data_base_date_collection_db
)
from app.model.encoder.disbursements_db import (
    insert_disbursement_db,
    insert_disbursement_bulk_db,
    get_disbursement_db,
    put_disbursement_db,
    delete_disbursement_db,
    get_data_base_date_disbursement_db,
    get_file_path_disbursements,
    remove_file_disbursements
)
from app.model.encoder.dfur_db import(
    insert_dfur_db,
    insert_dfur_bulk_db,
    get_all_dfur_db,
    put_dfur_db,
    delete_dfur_db
) 
from app.model.general.activity_logs import insert_activity_logs_db
from app.model.encoder.upload_validation_docs import update_add_file_path, get_file_path
from datetime import datetime
import random
from flask import request
# for insert bulk datatypes 
COLUMN_RULES = {

    "collection": {
        "required": [
            "transaction_date",
            "amount",
        ],
        "optional_defaults": {
            "transaction_id" : None,
            "nature_of_collection": None,
            "description": None,
            "fund_source": None,
            "payor": None,
            "or_number": None,
            "remarks": None,
            "created_by": None
        }
    },

    "disbursement": {
        "required": [
            "transaction_date",
            "amount",
            "allocation_id"
        ],
        "optional_defaults": {
            "transaction_id": None,
            "nature_of_disbursement": None,
            "description": None,
            "fund_source": None,
            "payee": None,
            "or_number": None,
            "remarks": None,
            "created_by": None,
        }
    },

    "budget_entries": {
        "required": [
            "transaction_date",
            "category",
            "amount"    
        ],
        "optional_defaults": {
            "transaction_id": None,
            "subcategory": None,
            "fund_source": None,
            "payee": None,
            "dv_number": None,
            "expenditure_program": None,
            "program_description": None,
            "remarks": None,
            "allocation_id": None
        }
    },

    "dfur": {
        "required": [
            "transaction_date",
            "name_of_collection",
            "project",
            "location"
        ],
        "optional_defaults": {
            "transaction_id": None,
            "total_cost_approved": 0,
            "total_cost_incurred": 0,
            "date_started": None,
            "target_completion_date": None,
            "status": None,
            "no_extensions": 0,
            "remarks": None
        }
    }
}
# Reserved/non-actual usernames that should fall back to default
SYSTEM_USERNAMES = {"system", "System", "SYSTEM", None, ""}

# inserting activity logs helper
def log_activity(user_id, username, action, module, description):
    resolved_user_id = user_id if user_id is not None else 4
    resolved_username = username if username not in SYSTEM_USERNAMES else "treasurer"
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

# CRUD ==================================================
# BUDGET ENTRIES
def insert_budget_entries_controller():
    try:
        entries = request.get_json()

        if not entries:
            return jsonify({"message": "No entries provided"}), 400

        created_by = entries["created_by"]

        success = insert_budget_entries_db(entries, created_by)

        if success:
            log_activity(entries.get("user_id"), entries.get("username"), "INSERT", "Budget Management", "A new budget entry has been successfully recorded in the system.")
            return jsonify({"message": "Budget entry inserted successfully"}), 200
        else:
            log_activity(entries.get("user_id"), entries.get("username"), "INSERT_FAILED", "Budget Management", "Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.")
            return jsonify({"message": "Failed to insert budget entry"}), 500

    except Exception as e:
        return jsonify({"message": str(e)}), 500


def get_budget_entries_controller():
    ...
    try:
        data = request.get_json()
        year = data["year"]
        
        if not year:
            return jsonify({"message": "No year provided"}), 400

        entries = get_budget_entries_db(year)

        if entries:
            #log_activity(data.get("user_id"), data.get("username"), "GET", "Budget Management", f"Budget entries for fiscal year {year} have been successfully retrieved.")
            return jsonify(entries), 200
        else:
            #log_activity(data.get("user_id"), data.get("username"), "GET_FAILED", "Budget Management", f"No budget entries were found for fiscal year {year}. The records may not exist or have been removed.")
            return jsonify({"message": "No budget entries found for the given year"}), 404
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def update_budget_entries_controller():
    ...
    try:
        ...
        entry = request.get_json()

        if not entry:
            return jsonify({"message": "No entries provided"}), 400

        success = put_budget_entries_db(entry)

        if success:
            log_activity(entry.get("user_id"), entry.get("username"), "UPDATE", "Budget Management", f"Budget entry has been successfully updated.")
            return jsonify({"message": "Budget entry updated successfully"}), 200
        else:
            log_activity(entry.get("user_id"), entry.get("username"), "UPDATE_FAILED", "Budget Management", f"Budget entry update failed. Please verify the entry ID and try again.")
            return jsonify({"message": "There is no budget entry try to check the id"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    
def delete_budget_entries_controller():
    ...
    try:
        ...
        data = request.get_json()
        entry_id = data["id"]

        if not entry_id:
            return jsonify({"message": "No entry ID provided"}), 400

        success = delete_budget_entries_db(entry_id)

        if success:
            log_activity(data.get("user_id"), data.get("username"), "DELETE", "Budget Management", f"Budget entry has been successfully deleted from the system.")
            return jsonify({"message": "Budget entry deleted successfully"}), 200
        else:
            log_activity(data.get("user_id"), data.get("username"), "DELETE_FAILED", "Budget Management", f"Budget entry deletion failed. Please verify the entry ID and try again.")
            return jsonify({"message": "Failed to delete budget entry"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500
 
# COLLECTION 
def insert_disbursement_controller():
    ...
    try:
        ...
        entry = request.get_json()
        if not entry:
            return jsonify({"message": "No entries provided"}), 400
        
        success = insert_disbursement_db(entry)

        if success:
            log_activity(entry.get("user_id"), entry.get("username"), "INSERT", "Disbursement Management", "A new disbursement record has been successfully recorded in the system.")
            return jsonify({"message": "disbursement entries inserted successfully"}), 200
        else:
            log_activity(entry.get("user_id"), entry.get("username"), "INSERT_FAILED", "Disbursement Management", "Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.")
            return jsonify({"message": "Failed to insert disbursement entries"}), 500  
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def get_disbursement_controller():
    ...
    try:
        ...
        disbursement = get_disbursement_db()
        if disbursement:
            #log_activity(None, None, "GET", "Disbursement Management", "All disbursement records were successfully retrieved.")
            return jsonify(disbursement), 200
        else:
            #log_activity(None, None, "GET_FAILED", "Disbursement Management", "Disbursement record retrieval failed. No records were found in the database.")
            return jsonify({"message": "Failed to get disbursement"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def put_disbursement_controller():
    ...
    try:
        ...
        entry = request.get_json()
        if not entry:
            return jsonify({"message": "No entries provided"}), 400

        success = put_disbursement_db(entry)

        if success:
            log_activity(entry.get("user_id"), entry.get("username"), "UPDATE", "Disbursement Management", f"Disbursement record has been successfully updated.")
            return jsonify({"message": "disbursement entries updated successfully"}), 200
        else:
            log_activity(entry.get("user_id"), entry.get("username"), "UPDATE_FAILED", "Disbursement Management", f"Disbursement record update failed. Please verify the record ID and try again.")
            return jsonify({"message": "There is no disbursement to update"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def delete_disbursement_controller():
    ...
    try:
        ...
        data = request.get_json()
        disbursement_id = data["disbursement_id"]
        success = delete_disbursement_db(disbursement_id)

        if success:
            log_activity(data.get("user_id"), data.get("username"), "DELETE", "Disbursement Management", f"Disbursement record has been successfully deleted from the system.")
            return jsonify({"message": "disbursement entries deleted successfully"}), 200
        else:
            log_activity(data.get("user_id"), data.get("username"), "DELETE_FAILED", "Disbursement Management", f"Disbursement record deletion failed. Please verify the record ID and try again.")
            return jsonify({"message": "Failed to delete disbursement entries"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    
    
# DISBURSEMENT
def insert_collection_controller():
    ...
    try:
        ...
        entry = request.get_json()
        if not entry:
            return jsonify({"message": "No entries provided"}), 400
        
        success = insert_collection_db(entry)

        if success:
            log_activity(entry.get("user_id"), entry.get("username"), "INSERT", "Collection Management", "A new collection record has been successfully recorded in the system.")
            return jsonify({"message": "Collection entries inserted successfully"}), 200
        else:
            log_activity(entry.get("user_id"), entry.get("username"), "INSERT_FAILED", "Collection Management", "Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.")
            return jsonify({"message": "Failed to insert collection entries"}), 500  
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def get_collection_controller():
    ...
    try:
        ...
        collection = get_collection_db()
        if collection:
            #log_activity(None, None, "GET", "Collection Management", "All collection records were successfully retrieved.")
            return jsonify(collection), 200
        else:
            #log_activity(None, None, "GET_FAILED", "Collection Management", "Collection record retrieval failed. No records were found in the database.")
            return jsonify({"message": "Failed to get collection"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def put_collection_controller():
    ...
    try:
        ...
        entry = request.get_json()
        if not entry:
            return jsonify({"message": "No entries provided"}), 400

        success = put_collection_db(entry)

        if success:
            log_activity(entry.get("user_id"), entry.get("username"), "UPDATE", "Collection Management", f"Collection record has been successfully updated.")
            return jsonify({"message": "Collection entries updated successfully"}), 200
        else:
            log_activity(entry.get("user_id"), entry.get("username"), "UPDATE_FAILED", "Collection Management", f"Collection record update failed. Please verify the record ID and try again.")
            return jsonify({"message": "There is no collection to update"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def delete_collection_controller():
    ...
    try:
        ...
        data = request.get_json()
        collection_id = data["collection_id"]
        success = delete_collection_db(collection_id)

        if success:
            log_activity(data.get("user_id"), data.get("username"), "DELETE", "Collection Management", f"Collection record has been successfully deleted from the system.")
            return jsonify({"message": "Collection entries deleted successfully"}), 200
        else:
            log_activity(data.get("user_id"), data.get("username"), "DELETE_FAILED", "Collection Management", f"Collection record deletion failed. Please verify the record ID and try again.")
            return jsonify({"message": "Failed to delete collection entries"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def get_data_base_range_date_controller():
    try:
        ...
        data = request.get_json()
        start_date = data["start_date"]
        end_date = data["end_date"]
        data_name = data["data_name"]
        print(data)
        if data_name == "collection":
            result = get_data_base_date_collection_db(start_date, end_date)
            #log_activity(data.get("user_id"), data.get("username"), "GET", "Collection Management", f"Collection records for the period {start_date} to {end_date} have been successfully retrieved.")
            return jsonify({"message": "Successfully retrieved data", "data": result}), 200
        elif data_name == "disbursement":
            result = get_data_base_date_disbursement_db(start_date, end_date)
            #log_activity(data.get("user_id"), data.get("username"), "GET", "Disbursement Management", f"Disbursement records for the period {start_date} to {end_date} have been successfully retrieved.")
            return jsonify({"message": "Successfully retrieved data", "data": result}), 200
        else:
            #log_activity(data.get("user_id"), data.get("username"), "GET_FAILED", "Data Range Query", f"Date-range query failed. The specified data type '{data_name}' is not recognized. Please provide a valid data type and try again.")
            return jsonify({"message": "Invalid data name"}), 400
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    

# DFUR PROJECT  
def insert_dfur_controller():
    try:
        data = request.get_json();
        if data['status'] == 'Planned':
            data['status'] = 'planned'
        elif data['status'] == 'Completed':
            data['status'] = 'completed'
        elif data['status'] == 'On Hold':
            data['status'] = 'on_hold'
        elif data['status'] == 'Cancelled':
            data['status'] = 'cancelled'
        elif data['status'] == 'In Progress':
            data['status'] = 'in_progress'
        
        result = insert_dfur_db(data)
        if result:
            log_activity(data.get("user_id"), data.get("username"), "INSERT", "DFUR Project Management", "A new DFUR project record has been successfully recorded in the system.")
            return jsonify({"message": "Successfully inserted data"}), 200
        else:
            log_activity(data.get("user_id"), data.get("username"), "INSERT_FAILED", "DFUR Project Management", "DFUR project record creation failed. The operation could not be completed. Please try again or contact the system administrator.")
            return jsonify({"message": "Failed to insert data"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    
def put_dfur_controller():
    try:
        data = request.get_json()
       
        if data['status'] == 'Planned':
            data['status'] = 'planned'
        elif data['status'] == 'Completed':
            data['status'] = 'completed'
        elif data['status'] == 'On Hold':
            data['status'] = 'on_hold'
        elif data['status'] == 'Cancelled':
            data['status'] = 'cancelled'
        elif data['status'] == 'In Progress':
            data['status'] = 'in_progress'
            
        result = put_dfur_db(data)
        
        if result:
            log_activity(data.get("user_id"), data.get("username"), "UPDATE", "DFUR Project Management", f"DFUR project record has been successfully updated.")
            return jsonify({"message": "Successfully updated data"}), 200
        else:
            log_activity(data.get("user_id"), data.get("username"), "UPDATE_FAILED", "DFUR Project Management", f"DFUR project record update failed. No matching record was found for ID: {data.get('id')}. Please verify the record ID and try again.")
            return jsonify({"message": "Failed to update data"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500

def get_dfur_controller():
    try:
        result = get_all_dfur_db()
        if result:
            #log_activity(None, None, "GET", "DFUR Project Management", "All DFUR project records were successfully retrieved.")
            return jsonify({"message": "Successfully retrieved data", "data": result}), 200
        else:
            #log_activity(None, None, "GET_FAILED", "DFUR Project Management", "DFUR project record retrieval failed. No records were found in the database.")
            return jsonify({"message": "Invalid data name"}), 400
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    
def delete_dfur_controller():
    try:
        data = request.get_json()
        id = data['id']
        result = delete_dfur_db(id)
        if result:
            log_activity(data.get("user_id"), data.get("username"), "DELETE", "DFUR Project Management", f"DFUR project record has been successfully deleted from the system.")
            return jsonify({"message": "Successfully deleted data"}), 200
        else:
            log_activity(data.get("user_id"), data.get("username"), "DELETE_FAILED", "DFUR Project Management", f"DFUR project record deletion failed. Please verify the record ID and try again.")
            return jsonify({"message": "Failed to delete data"}), 500
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    
# generate the ids
# auto generated id here ======================
def generate_transaction_id_controller(prefix, data_type):
    year = datetime.now().year

    if data_type == 'collection':
        entries = get_collection_db()
        prefix_key = f"COLL-{year}-"
    elif data_type == 'budget_entries':
        entries = get_budget_entries_db(year)
        prefix_key = f"BUDG-{year}-"
    elif data_type == 'disbursement':
        entries = get_disbursement_db()
        prefix_key = f"DISB-{year}-"
    elif data_type == 'dfur':
        entries = get_all_dfur_db()
        prefix_key = f"DFUR-{year}-"
    else:
        return f"{prefix}-{year}-001"

    max_counter = 0
    for entry in entries:
        tid = entry.get("transaction_id", "") or ""
        if tid.startswith(prefix_key):
            try:
                num = int(tid.split("-")[-1])
                if num > max_counter:
                    max_counter = num
            except ValueError:
                continue

    return f"{prefix}-{year}-{(max_counter + 1):03d}"

def generate_11_digit_number_controller():
    return random.randint(10_000_000_000, 99_999_999_999)
    
# BULK inserting blk field ============================================================================================
def validate_and_prepare_dataframe(df, data_type):

    rules = COLUMN_RULES.get(data_type)
    if not rules:
        raise ValueError("Invalid data_type")
    required = rules["required"]
    optional = rules["optional_defaults"]
    # Check missing required columns
    missing_required = [col for col in required if col not in df.columns]
    if missing_required:
        raise ValueError(
            f"Missing required columns: {', '.join(missing_required)}"
        )
    # Add optional columns if missing
    for col, default in optional.items():
        if col not in df.columns:
            df[col] = default
        else:
            if default is not None:
                df[col] = df[col].fillna(default)
    return df


def insert_excel_controller():
    try:

        file = request.files['file']
        data_type = request.form.get("data_type")
        df = pd.read_excel(file)
        # Validate columns
        df = validate_and_prepare_dataframe(df, data_type)
        data = df.to_dict(orient="records")

        PREFIX_MAP = {
            "collection": "COLL",
            "budget_entries": "BUDG",
            "disbursement": "DISB",
            "dfur": "DFUR"
        }
        # Get current count once
        year = datetime.now().year

        if data_type == "collection":
            counter = len(get_collection_db())

        elif data_type == "budget_entries":
            counter = len(get_budget_entries_db(year))

        elif data_type == "disbursement":
            counter = len(get_disbursement_db())

        elif data_type == "dfur":
            counter = len(get_all_dfur_db())

        for row in data:
            if not row.get("transaction_id"):
                counter += 1
                row["transaction_id"] = f"{PREFIX_MAP[data_type]}-{year}-{counter:03d}"

            if data_type == "budget_entries" and not row.get("dv_number"):
                row["dv_number"] = generate_11_digit_number_controller()
            
            if data_type == "collection" and not row.get("or_number"):
                row["or_number"] = generate_11_digit_number_controller()
            
            if data_type == "disbursement" and not row.get("or_number"):
                row["or_number"] = generate_11_digit_number_controller()
                
        # Insert to database
        if data_type == "collection":
            insert_collection_bulk_db(data)
        elif data_type == "disbursement":
            insert_disbursement_bulk_db(data)
        elif data_type == "budget_entries":
            created_by = request.form.get("created_by")
            insert_budget_entries_bulk_db(data, created_by)
        elif data_type == "dfur":
            insert_dfur_bulk_db(data)

        return jsonify({"message": "Bulk insert successful"}), 200
    except Exception as e:
        return jsonify({"message": str(e)}), 400

# =======================================================================================================
UPLOAD_FOLDER = "app/validation_docs"

# insert validation docs on the data
def upload_validation_docs_controller(id):
    try:
        data_type = request.form.get("data_type")
        uploaded_file = request.files.get("file") 
       
        print(f"Received file: {uploaded_file} for data type: {data_type} and ID: {id}")
        if not uploaded_file:
            return jsonify({"message": "No file uploaded"}), 400
        # Make filename safe
        filename = secure_filename(uploaded_file.filename)
        # Create folder if not exists
        os.makedirs(UPLOAD_FOLDER, exist_ok=True)
        # Full path
        file_path = os.path.join(UPLOAD_FOLDER, filename)
        # Save file
        uploaded_file.save(file_path)

        #Save file_path to DB depending on type
        if not update_add_file_path(id, data_type, file_path):
            return jsonify({"message": "Failed to update file path in database"}), 400

        return jsonify({
            "message": "File uploaded successfully",
            "file_path": file_path
        }), 200

    except Exception as e:
        return jsonify({"message": str(e)}), 400
    
def get_validation_docs_controller(id, data_type):
    BASE_URL = "https://barangayfinancetrackbackenddeployment.onrender.com"
    try:
        file_path = get_file_path(id, data_type)
        if not file_path:
            return jsonify({"message": "No file path found for the given ID and data type"}), 404
        
        clean_path = file_path.replace("\\", "/")
        filename = os.path.basename(clean_path)
        file_url = f"{BASE_URL}/api/files/{filename}"
        return jsonify({
            "message": "File path retrieved successfully",
            "file_url": file_url
        }), 200
    except Exception as e:
        return jsonify({"message": str(e)}), 400
    
def remove_validation_docs_controller(id, data_type):
    try:
        if not data_type:
            return jsonify({"message": "data_type is required"}), 400

        # Get current file path before clearing it
        file_path = get_file_path(id, data_type)

        # Clear the file path in DB (pass None/null to wipe it)
        if not update_add_file_path(id, data_type, None):
            return jsonify({"message": "Failed to remove file path from database"}), 400

        # Delete the actual file from disk if it exists
        if file_path:
            clean_path = file_path.replace("\\", "/")
            if os.path.exists(clean_path):
                os.remove(clean_path)

        return jsonify({"message": "File removed successfully"}), 200

    except Exception as e:
        return jsonify({"message": str(e)}), 400

# DISBURSEMENT ============================================================================
# upload the temp docs
DISBURSEMENT_UPLOAD_FOLDER = "app/disbursement-docs"

# -------------------- UPLOAD --------------------
def upload_disbursement_docs_controller():
    try:
        if 'file' not in request.files:
            return jsonify({"message": "No file part"}), 400

        file = request.files['file']

        if file.filename == "":
            return jsonify({"message": "No file selected"}), 400

        filename = secure_filename(file.filename)

        # Create folder if not exists
        os.makedirs(DISBURSEMENT_UPLOAD_FOLDER, exist_ok=True)

        # Save with entry id prefix to keep files unique per row
        unique_filename = f"{filename}"
        file_path = os.path.join(DISBURSEMENT_UPLOAD_FOLDER, unique_filename)
        file.save(file_path)

        BASE_URL = "https://barangayfinancetrackbackenddeployment.onrender.com"
        file_url = f"{BASE_URL}/api/disbursement-files/{unique_filename}"

        return jsonify({
            "message": "File uploaded successfully",
            "file_url": file_url,
            "file_path": file_path
        }), 200

    except Exception as e:
        print(f"Error in upload_disbursement_docs_controller: {e}")
        return jsonify({"message": str(e)}), 500


# -------------------- GET --------------------
def get_disbursement_docs_controller(id):
    try:
        BASE_URL = "https://barangayfinancetrackbackenddeployment.onrender.com"
        #BASE_URL = "http://127.0.0.1:5000"
        file_path = get_file_path_disbursements(id)

        if not file_path:
            return jsonify({"message": "No file found for this entry"}), 404

        # Extract filename from stored path
        filename = os.path.basename(file_path['supporting_doc'])

        file_url = f"{BASE_URL}/api/disbursement-files/{filename}"

        return jsonify({
            "message": "File retrieved successfully",
            "file_url": file_url
        }), 200

    except Exception as e:
        print(f"Error in get_disbursement_docs_controller: {e}")
        return jsonify({"message": str(e)}), 500

# -------------------- DELETE --------------------

def delete_disbursement_docs_controller(id):
    try:
        #  1. Get file path from DB
        file_path = get_file_path_disbursements(id)

        if not file_path:
            return jsonify({"message": "No file found for this entry"}), 404

        #  2. Delete file from folder
        if os.path.exists(file_path['supporting_doc']):
            os.remove(file_path['supporting_doc'])

        if not remove_file_disbursements(id):
            return jsonify({"message": "Error deleting file from database"}), 500
      
        return jsonify({"message": "File deleted successfully"}), 200

    except Exception as e:
        print(f"Error in delete_disbursement_docs_controller: {e}")
        return jsonify({"message": str(e)}), 500