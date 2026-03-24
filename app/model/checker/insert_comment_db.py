from app.utils.execute_query import execute_query

TABLE_MAP = {
    'collection':   'collections',
    'disbursement': 'disbursements',
    'dfur':         'dfur_projects',
}

def insert_flag_comment_db(flagged_by, username, comment, collection_id=None, disbursement_id=None, dfur_project_id=None):
    try:
        query = """
            INSERT INTO flag_comments (comment_text, flagged_by, collection_id, disbursement_id, dfur_project_id,  username)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        params = (
            comment,
            flagged_by,
            collection_id,
            disbursement_id,
            dfur_project_id,
            username,
        )
        return execute_query(query, params)

    except Exception as e:
        print("Insert flag comment error:", e)
        return False

def put_flagged_db(flag_type, record_id):
    try:
        table = TABLE_MAP.get(flag_type)
        if not table:
            return False

        query = f"""
            UPDATE {table}
            SET is_flagged = true
            WHERE id = %s
        """
        return execute_query(query, (record_id,))
    except Exception as e:
        print(e)
        return False