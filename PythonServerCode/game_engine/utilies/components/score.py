import json


class Score:
    def __init__(self, communication, empathy):
        self.empathy = empathy
        self.communication = communication

    def convert_to_json(self):
        data = {'empathy': self.empathy, 'communication': self.communication}
        json_object = json.dumps(data)
        print(json_object)
        return json_object
