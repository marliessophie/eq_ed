import pickle
from PythonServerCode.game_engine.question_engine import GameEngine

# TODO: replace creation of new object with pickling and loading
from PythonServerCode.constants import K


def main():
    # here add the level
    engine = GameEngine()
    # engine.add_item(K.introX1000)
    # engine.add_item(K.questionX1001)
    # engine.add_item(K.questionX1002)
    # engine.add_item(K.questionX1005)
    # engine.add_item(K.questionX1008)
    # file_to_store = open("game_engine_model.pickle", "wb")
    # pickle.dump(engine, file_to_store)
    # file_to_store.close()


if __name__ == "__main__":
    main()
