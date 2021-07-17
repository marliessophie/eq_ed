from PythonServerCode.game_engine.utilies.components.display import Display
import json


class Question(Display):
    def __init__(self, question_text, number_of_answers, answers, next_question_id):
        Display.__init__(self, question_text)
        self.number_of_answers = number_of_answers
        self.answers = answers
        self.next_question_id = next_question_id

    # def convert_answers_to_json(self):
    #     json_string = dict()
    #     for i in range(0, self.number_of_answers):
    #         print(self.answers[i].score.convert_to_json)
    #         #for j in range(0, 4):
    #             # {"key1": [1, 2, 3], "key2": [4, 5, 6]}
    #         # data = {
    #         #     "answer_text" + str(i): [self.answers[i].text],
    #         #     "answer_score" + str(i): [self.answers[i].score.convert_to_json],
    #         #     "answer_id" + str(i): [self.answers[i].answer_id],
    #         #     "next_question_id" + str(i): [self.answers[i].next_question_id]
    #         # }
    #         # json_dump = json.dumps(data)
    #         # print(json_dump)
    #     # print(json_string)
    #     json_object = json.dumps(json_string, indent=4)
    #     return json_object

    def add_answers(self):
        json_string = dict()
        for i in range(0, self.number_of_answers):
            json_string[i] = self.answers[i].answer_id
        json_object = json.dumps(json_string, indent=4)
        return json_object
