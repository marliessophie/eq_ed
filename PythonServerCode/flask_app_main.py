from flask import Flask, request, jsonify
import ast
import json
import jsonschema
from jsonschema import validate
import datetime
import pandas as pd
import pickle
import firebase_admin
from firebase_admin import credentials, db
from firebase_admin import firestore

from PythonServerCode.firebase_connect import get_level, get_answers, get_question
from PythonServerCode.game_engine.question_engine import GameEngine
from PythonServerCode.flask_errors import InvalidUsage

# TODO: remove print statements from production code

# todo - build third api endpoint for answers

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

# todo - seperate out db connection into seperate model

@app.route('/initLevelForUser', methods=['POST'])  # check deployment on AWS with boyd
def main_initLevelForUser_post():
    if request.method == 'POST':
        with open('json_schemas/schema_initLevelForUser_post.json') as sch_init:
            sch_init = json.load(sch_init)
            print(sch_init)

        json_data = request.get_json()
        print(json_data)
        if not validate_json(json_data, sch_init):
            raise InvalidUsage('Invalid json format. uid and next_question_id fields required',
                               status_code=400)

        print(f'json received is: {json_data}')
        uid = json_data['uid']
        level_id = json_data['level_id']

        # engine = GameEngine()
        # level_narrative = engine.get_next_item(level_id) f'Groups-Users/{groupID}/memberID'
        level_narrative = get_level(level_id)
        text = level_narrative['question_text']
        next_question_id = level_narrative['next_question_id']
        # if level_narrative['answers'] is None:
        #     answers = False

        # todo - score user by uid something like engine.score(uid, level_id)

        return json.dumps({'success': True, 'level_narrative': text, 'next_question_id': next_question_id}), \
               200, {'ContentType': 'application/json'}


@app.route('/getQuestionResponse', methods=['POST'])  # check deployment on AWS with boyd
def main_getQuestionResponse_post():
    if request.method == 'POST':
        with open('json_schemas/schema_getQuestionResponse_post.json') as sch_init:
            sch_init = json.load(sch_init)
            print(sch_init)

        json_data = request.get_json()
        # print(json_data)
        if not validate_json(json_data, sch_init):
            raise InvalidUsage('Invalid json format. uid and level_id fields required',
                               status_code=400)

        print(f'json received is: {json_data}')
        uid = json_data['uid']
        question_id = json_data['question_id']

        # engine = GameEngine()
        question = get_question(question_id)
        text = question['question_text']
        number_of_answers = question['number_of_answers']
        answer_ids = question['answers']
        answers = get_answers(answer_ids, number_of_answers)

        # todo - score user by uid something like engine.score(uid, level_id)

        return json.dumps({'success': True, 'question_text': text, 'number_of_answers': number_of_answers,
                           'answers': answers}), \
               200, {'ContentType': 'application/json'}


@app.route('/getLevelEnd', methods=['POST'])  # check deployment on AWS with boyd
def main_getLevelEnd_post():
    if request.method == 'POST':
        with open('json_schemas/schema_getLevelEnd_post.json') as sch_init:
            sch_init = json.load(sch_init)
            print(sch_init)

        json_data = request.get_json()
        print(json_data)
        if not validate_json(json_data, sch_init):
            raise InvalidUsage('Invalid json format. uid and level_id fields required',
                               status_code=400)

        print(f'json received is: {json_data}')
        uid = json_data['uid']
        question_id = json_data['question_id']

        # engine = GameEngine()
        question = get_level(question_id)
        # todo - include bool if user passed or not
        text = question['question_text']
        next_question_id = question['next_question_id']
        # todo - score user by uid something like engine.score(uid, level_id)

        return json.dumps({'success': True, 'question_text': text, 'next_question_id': next_question_id}), \
               200, {'ContentType': 'application/json'}


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
