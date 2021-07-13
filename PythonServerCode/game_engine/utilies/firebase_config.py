import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from PythonServerCode.constants import K
# from FlaskErrors import InvalidUsage # need to define this file


class DbConnection:

    def __init__(self):
        self.credentials = credentials.Certificate(K.cred)
        firebase_admin.initialize_app(self.credentials)
        self.db = firestore.client()  # stores client to firebase database

    def get_level_narrative(self, level_id):  # TODO: adjust this function to return the level narrative
        result = self.db.collection('questions').document(level_id).get()
        if result.exsits:
            print(result.to_dict())
            # return result
        else:
            print('There is no level with id: ' + level_id)

    # def completed_level(self, uid): # add user score to the database, and that they have completed a level
    def add_level_end_to_db(self, level_end, id):
        new_level_end_entry = {
            'question_text': level_end.text,
            'number_of_answers': None,
            'answers': None,
            'next_question_id': None,
            'question_id': id,
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
            'answers': question.convert_answers_to_json(),
            'next_question_id': question.next_question_id,
            'question_id': id,
        }

        # Add an entry in the question node
        ref = self.db.collection('questions')   # create db reference
        ref.document(id).set(new_question_entry)


# example for adding with auto id to the db
# db.collection('questions').add({'id': 'xx', 'answer_options': 'yy'})

# example for adding with custom id to the db
# db.collection('questions').document('id').set({'id': 'xx', 'answer_options': 'yy'}, merge=True) # will merge with exisiting entry


'''
what I can do is when I add a question then also put it in a dictionary and create class that holds question text, 
number of answers, answer (incl text, score, next)

next 
bool question 
string id 

'''

'''
def validateCreds(database_ver):
    if database_ver == 'PS':
        cred = credentials.Certificate('catchup-3b74a-firebase-adminsdk-ejuc8-ecb43ab5c5.json')
        firebase_admin.initialize_app(cred, {
        'databaseURL': 'https://catchup-3b74a-default-rtdb.europe-west1.firebasedatabase.app/'
        })
    if database_ver == 'catchup':
        # Group version: "...1957.json"
        cred = credentials.Certificate('catchup-c1b52-firebase-adminsdk-bmdox-e09f041957.json')
        firebase_admin.initialize_app(cred, {
            'databaseURL': 'https://catchup-c1b52-default-rtdb.europe-west1.firebasedatabase.app/'
        })

database_ver = 'catchup'
validateCreds(database_ver)
'''