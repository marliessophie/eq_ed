from PythonServerCode.game_engine.question_engine import GameEngine
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os
from pathlib import Path


def main():
    # here add the level
    engine = GameEngine()
    engine.get_current_question_list()


if __name__ == "__main__":
    main()