from PythonServerCode.game_engine.question_engine import GameEngine

# TODO: delete this file as not needed for production code >> only needed for model updates
from PythonServerCode.constants import K


def main():
    # here add the level
    engine = GameEngine()
    engine.add_item(K.questionX1001)


if __name__ == "__main__":
    main()
