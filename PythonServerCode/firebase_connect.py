import firebase_admin
import ast
from firebase_admin import credentials
from firebase_admin import firestore
from PythonServerCode.constants import K
from PythonServerCode.flask_errors import InvalidUsage
import json

credentials = credentials.Certificate(K.cred)
firebase_admin.initialize_app(credentials)
db = firestore.client()

def get_scores(level_id):
    docs = db.collection('user_data').stream()
    epp = 0
    cpp = 0
    epc = 0
    cpc = 0

    for doc in docs:
        doc = doc.to_dict()
        if "final_scores" in doc:
            scores = doc['final_scores']
            if level_id in scores:
                score = scores[level_id]
                epp = epp + score['final_ep_percentage']
                cpp = cpp + score['final_cp_percentage']
                epc = epc + 1
                cpc = cpc + 1

    print(epp/epc, cpp/cpc)


def get_json():
    data = db.collection('user_data').document('User1').get()
    data = data.to_dict()
    print(data)
    with open('user_data.json', 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)


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
    return answers, answer_ids


def uid_valid(uid):
    user = db.collection('user_data').document(uid).get()
    if not user.exists:
        return False
    return True


def score_user(uid, answer_id, level):
    # find the score and highscore by answer id
    cp, ep, hcp, hep = get_score_by_answer_id(answer_id)

    # get the users current scores for level 1
    ccp, cep, chcp, chep, attempts = get_user_current_score(uid, level)  #

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
    if not snapshot.exists:
        raise InvalidUsage('Answer ID not found.', status_code=403)

    snapshot = snapshot.to_dict()
    score = snapshot.get('score')
    highscore = snapshot.get('highscore')
    return score['CP'], score['EP'], highscore['CP'], highscore['EP']


def get_user_current_score(uid, level):
    # find current user in db by uid and find the ccp, cep, chcp, chep per level and return these
    snapshot = db.collection('user_data').document(uid).get()
    snapshot = snapshot.to_dict()
    current_score = snapshot.get('current_score')
    attempts = snapshot.get('attempts')

    # check if user has already got attempts, if not, set to one
    number_of_attempts = 1  # todo - check if this should be 0
    if attempts is not None:
        number_of_attempts = attempts

        # if this does not exist raise an InvalidUsage exception
    if current_score is None:
        raise InvalidUsage('Level not initiated.', status_code=403)

    score = current_score.get(level)
    return score['current_cp'], score['current_ep'], score['current_hcp'], score['current_hep'], number_of_attempts


def check_levels(level):
    if level == 'one':
        return 'two', 'three'
    if level == 'two':
        return 'one', 'three'
    if level == 'three':
        return 'one', 'two'


def transfer_user_score(question_id, uid):
    # look up in db if the user has passed or failed
    snapshot = db.collection('questions').document(question_id).get()
    snapshot = snapshot.to_dict()
    complete = snapshot.get('completed')

    # create mapping for level
    level = K.level_mapping[question_id[1]]

    # if passed the level then transfer the scores to permanent
    if complete:
        # get the temp scores from the db and calculate percentages
        ccp, cep, chcp, chep, attempts = get_user_current_score(uid, level)

        # check if final_scores exists
        snapshot = db.collection('user_data').document(uid).get()
        snapshot = snapshot.to_dict()
        final_scoring = snapshot.get('final_scores')

        if final_scoring:
            # data has to be gathered
            first_level_save, second_level_save = check_levels(level)

            # get data for first level save if it exists
            first_has_data = False
            second_has_data = False
            first = final_scoring.get(first_level_save)
            if first:
                first_has_data = True

            # get data for second level save if it exists
            second = final_scoring.get(second_level_save)
            if second:
                second_has_data = True

            if first_has_data and second_has_data:
                data = {
                    'attempts': attempts + 1,
                    'final_scores': {
                        level: {
                            'final_cp': ccp,
                            'final_ep': cep,
                            'final_hcp': chcp,
                            'final_hep': chep,
                            'final_cp_percentage': ccp / chcp,
                            'final_ep_percentage': cep / chep,
                        },
                        first_level_save: first,
                        second_level_save: second,
                    }
                }
                db.collection('user_data').document(uid).update(data)
                return complete

            if first_has_data:
                data = {
                    'attempts': attempts + 1,
                    'final_scores': {
                        level: {
                            'final_cp': ccp,
                            'final_ep': cep,
                            'final_hcp': chcp,
                            'final_hep': chep,
                            'final_cp_percentage': ccp / chcp,
                            'final_ep_percentage': cep / chep,
                        },
                        first_level_save: first,
                    }
                }
                db.collection('user_data').document(uid).update(data)
                return complete

            if second_has_data:
                data = {
                    'attempts': attempts + 1,
                    'final_scores': {
                        level: {
                            'final_cp': ccp,
                            'final_ep': cep,
                            'final_hcp': chcp,
                            'final_hep': chep,
                            'final_cp_percentage': ccp / chcp,
                            'final_ep_percentage': cep / chep,
                        },
                        second_level_save: second,
                    }
                }
                db.collection('user_data').document(uid).update(data)
                return complete

        # add score to permanent score and scale according to percentages
        data = {
            'attempts': attempts+1,
            'final_scores': {
                level: {
                    'final_cp': ccp,
                    'final_ep': cep,
                    'final_hcp': chcp,
                    'final_hep': chep,
                    'final_cp_percentage': ccp/chcp,
                    'final_ep_percentage': cep/chep,
                },
            }
        }
        db.collection('user_data').document(uid).update(data)

    return complete


class AnswerResponse:
    def __init__(self, text, next_question_id):
        self.text = text
        self.next_question_id = next_question_id
