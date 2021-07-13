# game engine for communication with database
from PythonServerCode.game_engine.utilies.firebase_config import DbConnection
from PythonServerCode.game_engine.utilies.item import Question, LevelEnd, Intro


# check if this needs to be initialised from db connection with all the exsisiting items in the db
class GameEngine:
    def __init__(self):
        self.user_scores = dict()
        self.db_connect = DbConnection()
        self.question_list = QuestionList()
        self.get_current_question_list()

    def get_current_question_list(self):  # TODO: query db for current question list
        # go through the question node in the db and add all the current questions here in the right format
        current_list = self.db_connect.db.collection('questions').get()
        print(current_list)
        # add items in current list to question list

    def get_temp_user_score(self):  # TODO: query db for user score
        pass

    # used for adding questions to levels
    def add_item(self, item):
        if not self.question_list.__contains__(item):
            self.question_list.__setitem__(item.item_id, item)
            if isinstance(item.display_item, Question):
                print('question')
                # self.db_connect.add_question_to_db(item.display_item, item.item_id)
            if isinstance(item.display_item, LevelEnd):
                print('level_end')
                # self.db_connect.add_level_end_to_db(item.display_item, item.item_id)
            if isinstance(item.display_item, Intro):
                self.db_connect.add_intro_to_db(item.display_item, item.item_id)

    # returns desired item from question list
    def get_next_item(self, key):
        return self.question_list.__getitem__(key)

    def enhance_score(self, uid, answer_id):  # TODO: connect this to db
        self.user_scores[uid] = self.question_list.__getitem__(answer_id).score


class QuestionList(dict):
    def __setitem__(self, key, item):
        self.__dict__[key] = item

    def __getitem__(self, key):
        return self.__dict__[key]

    def __repr__(self):
        return repr(self.__dict__)

    def __len__(self):
        return len(self.__dict__)

    def __delitem__(self, key):
        del self.__dict__[key]

    def clear(self):
        return self.__dict__.clear()

    def copy(self):
        return self.__dict__.copy()

    def has_key(self, k):
        return k in self.__dict__

    def update(self, *args, **kwargs):
        return self.__dict__.update(*args, **kwargs)

    def keys(self):
        return self.__dict__.keys()

    def values(self):
        return self.__dict__.values()

    def items(self):
        return self.__dict__.items()

    def pop(self, *args):
        return self.__dict__.pop(*args)

    def __cmp__(self, dict_):
        return self.__cmp__(self.__dict__, dict_)

    def __contains__(self, item):
        return item in self.__dict__

    def __iter__(self):
        return iter(self.__dict__)