# game engine for communication with database
from PythonServerCode.constants import K
from PythonServerCode.game_engine.utilies.components.intro import Intro
from PythonServerCode.game_engine.utilies.components.level_end import LevelEnd
from PythonServerCode.game_engine.utilies.components.question import Question
from PythonServerCode.game_engine.utilies.firebase_config import DbConnection
from PythonServerCode.game_engine.utilies.question_list import QuestionList


class GameEngine:
    def __init__(self):
        self.user_scores = dict()
        self.db_connect = DbConnection()
        self.question_list = QuestionList()
        self.get_current_question_list_initial()

    # this function only runs once when the model is first trained, and then not again
    def get_current_question_list_initial(self):
        current_list = self.db_connect.db.collection('questions').get()
        print(current_list)
        if current_list is not None:
            for snapshot in current_list:
                if snapshot.exists:
                    print('success')

    def update(self):
        current_list = self.db_connect.db.collection('questions').get()
        if current_list is not None:
            for snapshot in current_list:
                if snapshot.exists:
                    print('success')

    def get_temp_user_score(self):  # outsourced to the scoring model
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
        item = self.db_connect.db.collection('questions').document(key).get()
        print(item.to_dict())
        return item.to_dict()

    def enhance_score(self, uid, answer_id):  # outsourced to score model
        self.user_scores[uid] = self.question_list.__getitem__(answer_id).score
