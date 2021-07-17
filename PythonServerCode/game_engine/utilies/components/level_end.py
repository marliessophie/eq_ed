from PythonServerCode.game_engine.utilies.components.display import Display


class LevelEnd(Display):
    def __init__(self, completed, feedback_text):
        self.completed = completed
        Display.__init__(self, feedback_text)
    # think about how to include score push to db here
