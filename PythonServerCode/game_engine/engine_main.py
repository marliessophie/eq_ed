import pickle
from PythonServerCode.game_engine.question_engine import GameEngine
from PythonServerCode.constants import K

def main():
    engine = GameEngine()
    engine.add_item(K.introX1000)  # example for model addition


if __name__ == "__main__":
    main()
