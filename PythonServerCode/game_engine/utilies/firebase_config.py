import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from PythonServerCode.constants import K


class DbConnection:

    def __init__(self):
        self.credentials = credentials.Certificate(K.cred)
        firebase_admin.initialize_app(self.credentials)
        self.db = firestore.client()  # stores client to firebase database

    def get_level_narrative(self, level_id):
        result = self.db.collection('questions').document(level_id).get()
        if result.exsits:
            print(result.to_dict())
            # return result
        else:
            print('There is no level with id: ' + level_id)

    def add_level_end_to_db(self, level_end, id):
        new_level_end_entry = {
            'question_text': level_end.text,
            'number_of_answers': None,
            'answers': None,
            'next_question_id': None,
            'question_id': id,
            'completed': level_end.completed,
        }

        # Add an entry in the question node
        ref = self.db.collection('questions')  # create db reference
        ref.document(id).set(new_level_end_entry)

    # stores Question objects and question ids
    def add_intro_to_db(self, intro, id):
        new_level_end_entry = {
            'question_text': intro.text,
            'number_of_answers': None,
            'answers': None,
            'next_question_id': intro.next_question_id,
            'question_id': id,
        }

        # Add an entry in the question node
        ref = self.db.collection('questions')  # create db reference
        ref.document(id).set(new_level_end_entry)

    def add_question_to_db(self, question, id):
        new_question_entry = {
            'question_text': question.text,
            'number_of_answers': question.number_of_answers,
            'answers': question.add_answers(),
            'next_question_id': question.next_question_id,
            'question_id': id,
        }

        # add answers to db
        for i in range(0, question.number_of_answers):
            self.add_answers_to_db(question.answers[i])

        # Add an entry in the question node
        ref = self.db.collection('questions')   # create db reference
        ref.document(id).set(new_question_entry)

    def add_answers_to_db(self, answer):
        new_answer_entry = {
            'text': answer.text,
            'score': self.add_score_to_db(answer.score),
            'highscore': self.add_score_to_db(answer.highscore),
            'answer_id': answer.answer_id,
            'next_question_id': answer.next_question_id,
        }

        ref = self.db.collection('answers')  # create db reference
        ref.document(answer.answer_id).set(new_answer_entry)

    def add_score_to_db(self, score):
        score_entry = {'EP': score.empathy, 'CP': score.communication}
        return score_entry