from app.model.encoder.budget_entries_db import get_budget_entries_db
from app.model.encoder.dfur_db import get_all_dfur_db
from app.model.encoder.disbursements_db import get_disbursement_db
from app.model.encoder.collections_db import get_collection_db

def handle_data(data_name, year):
    try:
        if data_name == "budget_entries":
            data = get_budget_entries_db(year)
        elif data_name == "dfur_projects":
            data = get_all_dfur_db()
        elif data_name == "disbursements":
            data = get_disbursement_db()
        elif data_name == "collections":
            data = get_collection_db()
        else:
            data = []
        return data
    except Exception as e:
        print(e)
        return []

def total_count(data):
    try:
        ...
        return len(data)
    except Exception as e:
        print(e)
        return 0

def total_amount(data):
    try:
        ...
        if data[0]["amount"] is None:
            return 0
        return sum(item["amount"] for item in data)
    except Exception as e:
        print(e)
        return 0

def overall_cost_approved(data):
    try:
        ...
        if data[0]["total_cost_approved"] is None:
            return 0
        return sum(item["total_cost_approved"] for item in data)
    except Exception as e:
        print(e)
        return 0

def overall_cost_incurred(data):
    try:
        ...
        if data[0]["total_cost_incurred"] is None:
            return 0
        return sum(item["total_cost_incurred"] for item in data)
    except Exception as e:
        print(e)
        return 0

def total_active(data):
    try:
        ...
        if data[0]["is_active"] is None:
            return 0
        return len([item for item in data if item["is_active"] == 1])
    except Exception as e:
        print(e)
        return 0
    
def total_approved(data):
    try:
        ...
        if data[0]["review_status"] is None:
            return 0
        return len([item for item in data if item["review_status"] == "approved"])
    except Exception as e:
        print(e)
        return 0

def total_pending(data):
    try:
        ...
        if data[0]["review_status"] is None:
            return 0
        return len([item for item in data if item["review_status"] == "pending"])
    except Exception as e:
        print(e)
        return 0
    
def total_flagged(data):
    try:
        ...
        if data[0]["is_flagged"] is None:
            return 0
        return len([item for item in data if item["is_flagged"] == 1])
    except Exception as e:
        print(e)
        return 0
    
def result_total_data(data_name, year=None):
    try:
        ...
        # year is for budget entries
        data = handle_data(data_name, year)
            
        # call the function and create a data
        total_data = {}
        total_data["total_data"] = total_count(data)
        total_data["total_active"] = total_active(data)
        total_data["total_approved"] = total_approved(data)
        total_data["total_pending"] = total_pending(data)
        total_data["total_flagged"] = total_flagged(data)
        # if dfur there is no amount so change the data
        if data_name == "dfur_projects":
            total_data["overall_cost_approved"] = overall_cost_approved(data)
            total_data["overall_cost_incurred"] = overall_cost_incurred(data)
        else:
            total_data["total_amount"] = total_amount(data)
        
        return total_data
    except Exception as e:
        print(e)
        return 0
    
def get_variance_data(year=None):
    try:
        # ABO (Budget)
        budget_data = get_budget_entries_db(year)
        budget_total = sum(item.get("amount", 0) for item in budget_data) if budget_data else 0

        # Collections
        collections_data = get_collection_db()
        collections_total = sum(item.get("amount", 0) for item in collections_data) if collections_data else 0

        # Disbursements
        disbursement_data = get_disbursement_db()
        disbursement_total = sum(item.get("amount", 0) for item in disbursement_data) if disbursement_data else 0

        # SRE (Actual)
        actual_total = collections_total - disbursement_total

        # Variance
        variance = actual_total - budget_total

        # Status
        if variance > 0:
            status = "Unfavorable"
        elif variance < 0:
            status = "Favorable"
        else:
            status = "Balanced"

        return {
            "budget_total": budget_total,
            "collections_total": collections_total,
            "disbursement_total": disbursement_total,
            "actual_total": actual_total,
            "variance": variance,
            "status": status
        }

    except Exception as e:
        print(e)
        return {}