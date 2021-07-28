import firebase_admin
import ast
from firebase_admin import credentials
from firebase_admin import firestore
from PythonServerCode.constants import K
from PythonServerCode.flask_errors import InvalidUsage

credentials = credentials.Certificate(K.cred)
firebase_admin.initialize_app(credentials)
db = firestore.client()


def get_level(level_id):
    level_narrative = db.collection('questions').document(level_id).get()
    if not level_narrative.exists:
        raise InvalidUsage('Level ID not found.', status_code=403)
    level_narrative = level_narrative.to_dict()
    return level_narrative


def get_answers(answer_ids, number_of_answers):
    answer_ids = ast.literal_eval(answer_ids)
    print(answer_ids)
    answers = dict()
    for i in range(0, number_of_answers):
        answer_id = answer_ids[str(i)]
        print()
        answer_item = db.collection('answers').document(answer_id).get()
        if answer_item.exists:
            answer_item = answer_item.to_dict()
            print(answer_item)
            next_question_id = answer_item.get('next_question_id')
            if next_question_id not in answers:
                answers[next_question_id] = []
            answers[next_question_id].append(answer_item.get('text'))
        else:
            print('no')
    return answers


class AnswerResponse:
    def __init__(self, text, next_question_id):
        self.text = text
        self.next_question_id = next_question_id
