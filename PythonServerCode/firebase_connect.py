import firebase_admin
import ast
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import auth
from PythonServerCode.constants import K
from PythonServerCode.flask_errors import InvalidUsage

credentials = credentials.Certificate(K.cred)
firebase_admin.initialize_app(credentials)
db = firestore.client()


def init_level(level_id, uid):
    # second character in level id corresponds to the number of the level shown in the mapping
    level = K.level_mapping[level_id[1]]

    data = {
        'current_score': {
            level: {
                'current_cp': 0,
                'current_ep': 0,
                'current_hcp': 0,
                'current_hep': 0,
            }
        }
    }
    db.collection('user_data').document(uid).update(data)


def get_level(level_id):
    level_narrative = db.collection('questions').document(level_id).get()
    if not level_narrative.exists:
        raise InvalidUsage('Level ID not found.', status_code=403)
    level_narrative = level_narrative.to_dict()
    return level_narrative


def get_question(question_id):
    question = db.collection('questions').document(question_id).get()
    if not question.exists:
        raise InvalidUsage('Question ID not found.', status_code=403)
    level_narrative = question.to_dict()
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


def uid_valid(uid):
    user = db.collection('user_data').document(uid).get()
    if not user.exists:
        return False
    return True


def score_user(uid, answer_id, level):
    # find the score and highscore by answer id
    cp, ep, hcp, hep = get_score_by_answer_id(answer_id)

    # get the users current scores for level 1
    ccp, cep, chcp, chep = get_user_current_score(uid, level)

    # increase the current scores for level 1
    data = {
        'current_score': {
            level: {
                'current_cp': ccp+cp,
                'current_ep': cep+ep,
                'current_hcp': chcp+hcp,
                'current_hep': chep+hep,
            }
        }
    }
    db.collection('user_data').document(uid).update(data)


def get_score_by_answer_id(answer_id):
    # look up in db what the corresponding score is and return
    snapshot = db.collection('answers').document(answer_id).get()
    snapshot = snapshot.to_dict()
    score = snapshot.get('score')
    highscore = snapshot.get('highscore')
    return score['CP'], score['EP'], highscore['CP'], highscore['EP']


def get_user_current_score(uid, level):
    # find current user in db by uid and find the ccp, cep, chcp, chep per level and return these
    snapshot = db.collection('user_data').document(uid).get()
    snapshot = snapshot.to_dict()
    current_score = snapshot.get('current_score')

    # if this does not exist raise an InvalidUsage exception
    if current_score is None:
        raise InvalidUsage('Level not initiated.', status_code=403)

    score = current_score.get(level)
    return score['current_cp'], score['current_ep'], score['current_hcp'], score['current_hep']


def transfer_user_score(question_id):
    # todo - think of scoring mechanism here to get percentages
    # look up in db if the user has passed or failed
    pass

    # if passed the level then transfer the scores to permanent

    # if not passed the level then do not transfer scores, hence do nothing

    # set temp scores to zero


class AnswerResponse:
    def __init__(self, text, next_question_id):
        self.text = text
        self.next_question_id = next_question_id
