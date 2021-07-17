# game engine for communication with database
from PythonServerCode.game_engine.utilies.firebase_config import DbConnection
from PythonServerCode.game_engine.utilies.item import Question, LevelEnd, Intro
from PythonServerCode.game_engine.utilies.question_list import QuestionList

# TODO: check with boyd approach of saving model in pickle file
# TODO: save game engine object in pickle file and retrain when necessary
# TODO: define separate model for scoring user working with db, saving current user score and gameEngine
# TODO: work on API calls from server side to send back data in format that is expected
# TODO: detail out json schema for return to front end for level data
# TODO: detail out json schema for scoring model given the user
# TODO: note down assumption for thesis
# TODO: refactor code classes
# TODO: add remaining levels to the db


class GameEngine:
    def __init__(self):
        self.user_scores = dict()
        self.db_connect = DbConnection()
        self.question_list = QuestionList()
        self.get_current_question_list_initial()

    # this function only runs once when the model is first trained, and then not again
    def get_current_question_list_initial(self):  # TODO: query db for current question list
        # go through the question node in the db and add all the current questions here in the right format
        current_list = self.db_connect.db.collection('questions').get()
        print(current_list)
        if current_list is not None:
            for snapshot in current_list:
                if snapshot.exists:
                    print(snapshot)
                    # check what kind of instance it is
                    # add item to question list
        # add items in current list to question list

    def update(self):  # TODO: go through db and add the questions that are not in the model
        current_list = self.db_connect.db.collection('questions').get()
        if current_list is not None:
            for snapshot in current_list:
                if snapshot.exists:
                    # check if key already exists, if it does not, then add to the list in the model
                    print('success')

    def get_temp_user_score(self):  # TODO: outsource this to the score model
        pass

    # used for adding questions to levels
    def add_item(self, item):
        if not self.question_list.__contains__(item):
            self.question_list.__setitem__(item.item_id, item)
            if isinstance(item.display_item, Question):
                self.db_connect.add_question_to_db(item.display_item, item.item_id)
            if isinstance(item.display_item, LevelEnd):
                self.db_connect.add_level_end_to_db(item.display_item, item.item_id)
            if isinstance(item.display_item, Intro):
                self.db_connect.add_intro_to_db(item.display_item, item.item_id)

    # returns desired item from question list
    def get_next_item(self, key):
        return self.question_list.__getitem__(key)

    def enhance_score(self, uid, answer_id):  # TODO: outsource this to score model
        self.user_scores[uid] = self.question_list.__getitem__(answer_id).score



