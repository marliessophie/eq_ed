from PythonServerCode.constants import K
from PythonServerCode.game_engine.question_engine import GameEngine


def main():
    # here add the level
    engine = GameEngine()
    # engine.add_item(K.introX1000)
    engine.get_current_question_list_initial()


if __name__ == "__main__":
    main()