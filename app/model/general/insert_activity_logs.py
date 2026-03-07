from app.utils import execute_query

def insert_activity_logs_db(user_id, activity):

    query = """
        INSERT INTO activity_logs
        (user_id, username, action, module, description, ip_address, user_agent)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """

    params = (
        user_id,
        activity.get("username"),
        activity.get("action"),
        activity.get("module"),
        activity.get("description"),
        activity.get("ip_address"),
        activity.get("user_agent")
    )

    execute_query(query, params)