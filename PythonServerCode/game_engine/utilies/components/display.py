from abc import ABC


class Display(ABC):
    def __init__(self, text):
        self.text = text