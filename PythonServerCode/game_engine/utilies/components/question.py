from PythonServerCode.game_engine.utilies.components.display import Display
import json


class Question(Display):
    def __init__(self, question_text, number_of_answers, answers, next_question_id):
        Display.__init__(self, question_text)
        self.number_of_answers = number_of_answers
        self.answers = answers
        self.next_question_id = next_question_id

    def add_answers(self):
        json_string = dict()
        for i in range(0, self.number_of_answers):
            json_string[i] = self.answers[i].answer_id
        json_object = json.dumps(json_string, indent=4)
        return json_object
