import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# from FlaskErrors import InvalidUsage # need to define this file

cred = credentials.Certificate("path/to/service_account_key.json")
firebase_admin.initialize_app(cred)

# stores client to firebase database
db = firestore.client()

# example for adding with auto id to the db
# db.collection('questions').add({'id': 'xx', 'answer_options': 'yy'})

# example for adding with custom id to the db
# db.collection('questions').document('id').set({'id': 'xx', 'answer_options': 'yy'}, merge=True) # will merge with exisiting entry


def get_level_narrative(level_id):
    result = db.collection() # finish this

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