from flask import Blueprint, request
from app.controllers.checker_controller import (
    insert_flag_comment_controller,
    get_flag_comments_controller
)

checker_bp = Blueprint('checker_bp', __name__)

@checker_bp.route('/insert-flag-comment', methods=['POST'])
def insert_flag_comment():
    ...
    # {
    #     "collection_id": 1,
    #     "reviewed_by": 3,
    #     "comment": "The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.",
    #     "flag_type": "collection"
    # }
     # {
    #     "disbursement_id": 1,
    #     "reviewed_by": 3,
    #     "comment": "The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.",
    #     "flag_type": "disbursement"
    # }
     # {
    #     "dfur_id": 1,
    #     "reviewed_by": 3,
    #     "comment": "The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.",
    #     "flag_type": "dfur"
    # }
    return insert_flag_comment_controller()

@checker_bp.route('/get-flag-comments', methods=['GET'])
def get_flag_comments():
    flag_type = request.args.get('flag_type')
    record_id = request.args.get('record_id')
    return get_flag_comments_controller(flag_type, record_id)
