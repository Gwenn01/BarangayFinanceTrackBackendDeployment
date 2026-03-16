from app.utils.execute_query import execute_query, fetch_all

def get_flag_comments_db(flag_type, record_id):
    try:
        TYPE_COLUMN_MAP = {
            'collection':   'collection_id',
            'disbursement': 'disbursement_id',
            'dfur': 'dfur_project_id',
        }

        column = TYPE_COLUMN_MAP.get(flag_type)
        if not column:
            return None

        query = f"""
            SELECT 
                fc.id,
                fc.comment_text,
                fc.username,
                fc.flagged_by,
                fc.created_at
            FROM flag_comments fc
            WHERE fc.{column} = %s
            ORDER BY fc.created_at DESC
        """

        return fetch_all(query, (record_id,))  # ← fixed here

    except Exception as e:
        print("Get flag comments error:", e)
        return None