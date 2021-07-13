from PythonServerCode.game_engine.utilies.item import Intro, Item
from pathlib import Path
import os


class K:
    path = Path(__file__).parent
    cred = os.path.join(path, 'json_schemas/serviceAccountKey.json')
    introX1000 = Item(
        Intro(
            "Setting: User is in a team meeting setting with 2 NPCs. " \
            "They are discussing how to best approach answering the question" \
            " given in an assignment: \"What is the future of work?\". The " \
            "group should create a presentation answering this question. " \
            "The user first listens to the others discussing. ",
            1001,
        ),
        1000)



