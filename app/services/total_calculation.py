from app.model.encoder.budget_entries_db import get_budget_entries_db
from app.model.encoder.dfur_db import get_all_dfur_db
from app.model.encoder.disbursements_db import get_disbursement_db
from app.model.encoder.collections_db import get_collection_db
from collections import defaultdict

# sub functions ============================================================================================
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
    
def get_source_type(nature):
    for category, items in COLLECTION_MAPPING.items():
        if nature in items:
            return category
    return "Other"

def get_disbursement_category(nature):
    for category, data in DISBURSEMENT_CATEGORIES.items():
        for sub_list in data["subcategories"].values():
            if nature in sub_list:
                return category
    return "Other"
# result data =============================================================================================================    
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
 # variance for encoder dashboard ====================================================================================   
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

# revenue and expenditure sources ================================================================================================
COLLECTION_MAPPING = {
    "External": [
        "Share from Real Property Tax",
        "Tax on Sand, Gravel & Other Quarry Resources",
        "Other Taxes (Community Tax / CTC)",
        "Internal Revenue Allotment (IRA) / National Tax Allotment (NTA)",
        "Share from National Wealth",
        "Tobacco Excise Tax (RA 7171 / 8240)",
        "Subsidy from LGUs",
        "Subsidy from National Government"
    ],
    "Internal": [
        "Clearance and Certification Fees",
        "Barangay Clearance Fees",
        "Barangay Business Clearance",
        "Barangay Residency",
        "K.P. Filing fees",
        "Other Service Income"
    ],
    "Non-Income": [
        "Refunds / Reimbursements",
        "Sale of Property or Equipment",
        "Interest Income / Dividend",
        "Loans / Borrowings Proceeds",
        "Fund raising proceeds for specific/ temporary purpose"
    ]
}

def compute_collection_summary():
    totals = defaultdict(float)
    collections = handle_data('collections', 2026)
    # Step 1: classify + sum
    for row in collections:
        source_type = get_source_type(row["nature_of_collection"])
        totals[source_type] += float(row["amount"])

    # Step 2: grand total
    grand_total = sum(totals.values())

    # Step 3: compute percentage
    result = []
    for category, total in totals.items():
        percentage = (total / grand_total * 100) if grand_total > 0 else 0
        result.append({
            "category": category,
            "total": total,
            "percentage": round(percentage, 2)
        })

    return result

DISBURSEMENT_CATEGORIES = {
    "A. Personal Services": {
        "label": "A. Personal Services",
        "subcategories": {
            "Personal Services": [
                "Honoraria",
                "Cash gift",
                "Mid year bonus",
                "Year end bonus",
                "Productivity Enhancement Incentive (PEI)",
                "Annual leave benefits",
            ],
        },
    },
    "B. Maintenance and Other Operating Expenses (MOOE)": {
        "label": "B. Maintenance and Other Operating Expenses (MOOE)",
        "subcategories": {
            "Operating Expenses": [
                "Traveling Expenses",
                "Training Expenses",
                "Office Supplies Expenses",
                "Accountable Forms Expenses",
                "Electricity Expenses",
                "Auditing Services",
                "Bookkeeping Services",
                "Fuel, Oil, and Lubricants",
                "Other supplies and materials expenses",
                "Drugs and Medicines expenses",
                "Uniforms and Clothing Expenses",
                "Representation Expense",
                "Fidelity Bond Premiums",
                "Repairs and Maintenance- Building and Other Structures Maintenance and Repair Expenses",
                "Transportation Equipment",
                "Other Professional Services",
                "Other Personal services",
                "Other General Services",
                "Janitorial Services",
                "Waste Segregation Management",
                "Insurance Premium",
                "Discretionary Fund",
                "Membership Dues and Contributions to Organizations",
                "Donations",
                "Other MOOE",
            ],
        },
    },
    "C. Capital Outlay": {
        "label": "C. Capital Outlay",
        "subcategories": {
            "Capital Expenditures": [
                "Land Improvements",
                "Infrastructure Assets- Buildings and Other Structures",
                "Machinery and Equipment",
                "Transportation Equipment",
                "Furniture, Fixtures and Books",
                "Other P.P.E",
            ],
        },
    },
    "D. Special Purpose Appropriations (SPA)": {
        "label": "D. Special Purpose Appropriations (SPA)",
        "subcategories": {
            "Special Appropriations": [
                "Appropriation for SK",
                "Other Authorized SPAs",
            ],
        },
    },
    "E. Basic Services and Facilities Program - SOCIAL SERVICES": {
        "label": "E. Basic Services and Facilities Program - SOCIAL SERVICES",
        "subcategories": {
            "Day Care Services": [
                "Subsidy to Day Care Worker",
            ],
            "Health and Nutrition Services": [
                "Subsidy to BHWs and Brgy, Nutrition Scholars",
            ],
            "Peace and Order Services": [
                "Subsidy to BPATS",
            ],
            "Katarungang Pambarangay Services": [
                "Subsidy to Lupon Members",
            ],
        },
    },
    "F. Infrastructure Projects - 20% Development Fund - ECONOMIC SERVICES": {
        "label": "F. Infrastructure Projects - ECONOMIC SERVICES",
        "subcategories": {
            "Infrastructure Development": [
                "Rehabilitation/Repair of Barangay Jail",
                "Construction Extension shed of Brgy. Covered Court",
                "Construction/Extension of Barangay Shed or Hall",
                "Construction of Kitchen & Stock Room",
                "Improvement of Rooftop",
                "Construction of Welcome Signage",
                "Construction of Canals",
                "Installation of CCTV Cameras",
                "Repair of Barangay Hall, Covered Court, & Fence",
                "Fabrication & Repair of Signages",
            ],
        },
    },
    "G. Other Services": {
        "label": "G. Other Services",
        "subcategories": {
            "Quick Response Fund (QRF) Activities": [
                "Purchase of food commodities",
                "Disaster Preparedness, Prevention and Mitigation Response Rehabilitation and Recovery",
                "Purchased of expandable items",
                "Declogging and Dredging of Canals",
                "Tree and Bushes pruning",
                "Conducting fire and Earthquake Drill",
            ],
            "Other Community Services": [
                "Senior Citizen/PWDs Services",
                "BCPC",
                "Others",
            ],
        },
    },
}

# =========================
# DISBURSEMENT SUMMARY
# =========================
def compute_disbursement_summary():
    totals = defaultdict(float)

    disbursements = handle_data('disbursements', 2026)

    for row in disbursements:
        nature = row.get("nature_of_disbursement", "")
        amount = float(row.get("amount", 0))

        category = get_disbursement_category(nature)
        totals[category] += amount

    grand_total = sum(totals.values())

    result = []
    for category, total in totals.items():
        percentage = (total / grand_total * 100) if grand_total > 0 else 0

        result.append({
            "category": category,
            "total": round(total, 2),
            "percentage": round(percentage, 2)
        })

    return sorted(result, key=lambda x: x["category"])