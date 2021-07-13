# game engine for communication with database
from game_engine.item import Question, LevelEnd, Intro


class GameEngine:
    def __init__(self, question_list):
        self.question_list = question_list
        self.user_scores = dict()

    # used for adding questions to levels
    def add_item(self, item):
        self.question_list.__setitem__(item.id, item)
        if isinstance(item.display_item, Question):
            self.add_question_to_db(item.display_item, item.item_id)
        if isinstance(item.display_item, LevelEnd):
            self.add_level_end_to_db(item.display_item, item.item_id)
        if isinstance(item.display_item, Intro):
            self.add_intro_to_db(item.display_item, item.item_id)

    # returns desired item from question list
    def get_next_item(self, key):
        return self.question_list.__getitem__(key)

    def enhance_score(self, uid, answer_id):
        self.user_scores[uid] = self.question_list.__getitem__(answer_id).score

    # def completed_level(self, uid): # add user score to the database, and that they have completed a level
    def add_level_end_to_db(self, item, id):
        pass

    # stores Question objects and question ids
    def add_intro_to_db(self, item, id):
        pass

    def add_question_to_db(self, question, id):
        new_question_entry = {
            'question_text': question.question_text,
            'number_of_answers': question.number_of_answers,
            'answers': question.convert_answers_to_json(),
            'next_question_id': question.next_question_id,
            'question_id': id,
        }

        # Add an entry in the question node
        ref = db.reference('questions')   # create db reference
        ref.document(id).set(new_question_entry)


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