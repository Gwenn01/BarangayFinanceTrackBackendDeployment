from app.utils.execute_query import execute_query, fetch_all

def update_add_file_path(id, data_type, file_path):
    try:
        if data_type == "budget_entries":
            query = "UPDATE budget_entries SET file_path=%s WHERE id=%s"
            params = (file_path, id)
        elif data_type == "collections":
            query = "UPDATE collections SET file_path=%s WHERE id=%s"
            params = (file_path, id)
        elif data_type == "disbursements":
            query = "UPDATE disbursements SET file_path=%s WHERE id=%s"
            params = (file_path, id)
        elif data_type == "dfur_projects":
            query = "UPDATE dfur_projects SET file_path=%s WHERE id=%s"
            params = (file_path, id)
        else:
            raise ValueError("Invalid data type")
        
        return execute_query(query, params)
    except Exception as e:
        print(f"Error updating file path: {e}")
        return False
    
    
def get_file_path(id, data_type):
    try:
        if data_type == "budget_entries":
            query = "SELECT file_path FROM budget_entries WHERE id=%s"
            params = (id,)
        elif data_type == "collections":
            query = "SELECT file_path FROM collections WHERE id=%s"
            params = (id,)
        elif data_type == "disbursements":
            query = "SELECT file_path FROM disbursements WHERE id=%s"
            params = (id,)
        elif data_type == "dfur_projects":
            query = "SELECT file_path FROM dfur_projects WHERE id=%s"
            params = (id,)
        else:
            raise ValueError("Invalid data type")
        
        result = fetch_all(query, params)
        return result[0]['file_path'] if result else None
    except Exception as e:
        print(f"Error fetching file path: {e}")
        return None