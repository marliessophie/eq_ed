from abc import ABC
import json


class Display(ABC):
    def __init__(self, text):
        self.text = text


# need an intro class for showing the scenario
class Intro(Display):
    def __init__(self, intro_text, next_question_id):
        Display.__init__(self, intro_text)
        self.next_question_id = next_question_id


class Question(Display):
    def __init__(self, question_text, number_of_answers, answers, next_question_id):
        self.question_text = question_text
        Display.__init__(self, question_text)
        self.number_of_answers = number_of_answers
        self.answers = answers
        self.next_question_id = next_question_id

    def convert_answers_to_json(self):
        json_string = dict()
        for i in range(0, self.number_of_answers):
            json_string[i] = self.answers[i]
        json_object = json.dumps(json_string, indent=4)
        return json_object


class LevelEnd(Display):
    def __init__(self, completed, feedback_text):
        self.completed = completed
        Display.__init__(self, feedback_text)
    # think about how to include score push to db here


class Item:
    def __init__(self, display_item, item_id):
        self.item_id = item_id
        self.display_item = display_item
        if isinstance(display_item, Question):
            self.question = True


class Answer:
    def __init__(self, text, score):
        self.text = text
        self.score = score


class Score:
    def __init__(self, empathy, communication):
        self.empathy = empathy
        self.communication = communication
