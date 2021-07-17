from PythonServerCode.game_engine.utilies.components.question import Question


# TODO: think of this class structure


class Item:
    def __init__(self, display_item, item_id):
        self.item_id = item_id
        self.display_item = display_item
        if isinstance(display_item, Question):
            self.question = True
