from flask import Flask, request, jsonify
import ast
import json
import jsonschema
from jsonschema import validate
import datetime
import pandas as pd
import pickle

from PythonServerCode.game_engine.question_engine import GameEngine
from flask_errors import InvalidUsage

# TODO: remove print statements from production code

app = Flask(__name__)


def validate_json(json_data, api_schema):
    try:
        jsonschema.validate(instance=json_data, schema=api_schema)
        is_valid = True
    except jsonschema.exceptions.ValidationError as err:
        is_valid = False
    return is_valid


@app.errorhandler(InvalidUsage)
def handle_invalid_usage(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    print(response)
    return response


# need api endpoint to record user responses in scoring model and return the next question conditional on decision
# create proper scheme for usage

@app.route('/initLevelForUser', methods=['POST'])  # check deployment on AWS with boyd
def main_initLevelForUser_post():
    if request.method == 'POST':
        with open('json_schemas/schema_initLevelForUser_post.json') as sch_init:
            sch_init = json.load(sch_init)
            print(sch_init)

        json_data = request.get_json()
        print(json_data)
        if not validate_json(json_data, sch_init):
            raise InvalidUsage('Invalid json format. uid and level_id fields required',
                               status_code=400)

        print(f'json received is: {json_data}')
        uid = json_data['uid']
        level_id = json_data['level_id']

        engine = GameEngine()
        level_narrative = engine.get_next_item(level_id)
        text = level_narrative['question_text']
        next_question_id = level_narrative['next_question_id']
        # if level_narrative['answers'] is None:
        #     answers = False

        # todo - score user by uid something like engine.score(uid, level_id)

        return json.dumps({'success': True, 'level_narrative': text, 'next_question_id': next_question_id}), \
               200, {'ContentType': 'application/json'}


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)  # TODO: AWS connection
