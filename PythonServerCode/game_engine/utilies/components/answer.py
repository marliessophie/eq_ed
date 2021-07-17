from PythonServerCode.game_engine.utilies.components.display import Display


class Answer(Display):
    def __init__(self, text, score, answer_id, next_question_id):
        Display.__init__(self, text)
        self.score = score
        self.answer_id = answer_id
        self.next_question_id = next_question_id
