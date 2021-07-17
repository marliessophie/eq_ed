from PythonServerCode.game_engine.utilies.components.display import Display


class Intro(Display):
    def __init__(self, intro_text, next_question_id):
        Display.__init__(self, intro_text)
        self.next_question_id = next_question_id
