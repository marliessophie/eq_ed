from abc import ABC
import json

# TODO: separate out classes into separate files


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
        Display.__init__(self, question_text)
        self.number_of_answers = number_of_answers
        self.answers = answers
        self.next_question_id = next_question_id

    def convert_answers_to_json(self):
        json_string = dict()
        for i in range(0, self.number_of_answers):
            print(self.answers[i].score.convert_to_json)
            #for j in range(0, 4):
                # {"key1": [1, 2, 3], "key2": [4, 5, 6]}
            # data = {
            #     "answer_text" + str(i): [self.answers[i].text],
            #     "answer_score" + str(i): [self.answers[i].score.convert_to_json],
            #     "answer_id" + str(i): [self.answers[i].answer_id],
            #     "next_question_id" + str(i): [self.answers[i].next_question_id]
            # }
            # json_dump = json.dumps(data)
            # print(json_dump)
        # print(json_string)
        json_object = json.dumps(json_string, indent=4)
        return json_object

    def add_answers(self):
        json_string = dict()
        for i in range(0, self.number_of_answers):
            json_string[i] = self.answers[i].answer_id
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
    def __init__(self, text, score, answer_id, next_question_id):
        self.text = text
        self.score = score
        self.answer_id = answer_id
        self.next_question_id = next_question_id


class Score:
    def __init__(self, communication, empathy):
        self.empathy = empathy
        self.communication = communication

    def convert_to_json(self):
        data = {'empathy': self.empathy, 'communication': self.communication}
        json_object = json.dumps(data)
        print(json_object)
        return json_object
