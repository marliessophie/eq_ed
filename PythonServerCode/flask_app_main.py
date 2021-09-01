from flask import Flask, request, jsonify
import ast
import json
import jsonschema
from jsonschema import validate
import datetime
import pandas as pd
import pickle

from constants import K
from firebase_connect import get_level, get_answers, get_question, uid_valid, score_user, init_level, \
    transfer_user_score
from flask_errors import InvalidUsage

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


# todo - seperate out db connection into seperate model

@app.route('/initLevelForUser', methods=['POST'])
def main_initLevelForUser_post():
    if request.method == 'POST':
        with open('json_schemas/schema_initLevelForUser_post.json') as sch_init:
            sch_init = json.load(sch_init)
            print(sch_init)

        json_data = request.get_json()
        if not validate_json(json_data, sch_init):
            raise InvalidUsage('Invalid json format. uid and next_question_id fields required',
                               status_code=400)

        print(f'json received is: {json_data}')
        uid = json_data['uid']
        level_id = json_data['level_id']

        # engine = GameEngine()
        level_narrative = get_level(level_id)
        text = level_narrative['question_text']
        next_question_id = level_narrative['next_question_id']

        # set the current scores to none
        init_level(level_id, uid)

        return json.dumps({'success': True, 'level_narrative': text, 'next_question_id': next_question_id}), \
               200, {'ContentType': 'application/json'}


@app.route('/getQuestionResponse', methods=['POST'])
def main_getQuestionResponse_post():
    if request.method == 'POST':
        with open('json_schemas/schema_getQuestionResponse_post.json') as sch_init:
            sch_init = json.load(sch_init)
            print(sch_init)

        json_data = request.get_json()
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
        answers, answer_ids = get_answers(answer_ids, number_of_answers)

        return json.dumps({'success': True, 'question_text': text, 'number_of_answers': number_of_answers,
                           'answers': answers, 'answer_ids': answer_ids}), \
               200, {'ContentType': 'application/json'}


@app.route('/getLevelEnd', methods=['POST'])
def main_getLevelEnd_post():
    if request.method == 'POST':
        with open('json_schemas/schema_getLevelEnd_post.json') as sch_init:
            sch_init = json.load(sch_init)
            print(sch_init)

        json_data = request.get_json()
        if not validate_json(json_data, sch_init):
            raise InvalidUsage('Invalid json format. uid and level_id fields required',
                               status_code=400)

        print(f'json received is: {json_data}')
        uid = json_data['uid']
        question_id = json_data['question_id']

        # engine = GameEngine()
        question = get_level(question_id)
        completed = False

        # end of level if should start with a Z, then the level is completed
        if question_id[0] == 'Z':
            completed = transfer_user_score(question_id, uid)

        text = question['question_text']
        next_question_id = question['next_question_id']

        return json.dumps({'success': True, 'question_text': text, 'next_question_id': next_question_id,
                           'completed': completed}), \
               200, {'ContentType': 'application/json'}


@app.route('/scoreUser', methods=['POST'])
def main_scoreUser_post():
    if request.method == 'POST':
        with open('json_schemas/schema_scoreUser_post.json') as sch_init:
            sch_init = json.load(sch_init)
            print(sch_init)

        json_data = request.get_json()
        print(json_data)
        if not validate_json(json_data, sch_init):
            raise InvalidUsage('Invalid json format. uid and answer_id fields required',
                               status_code=400)

        uid = json_data['uid']
        answer_id = json_data['answer_id']
        if not uid_valid(uid):
            raise InvalidUsage('User ID not found.', status_code=403)

        if answer_id == "":
            raise InvalidUsage('Invalid json format. uid and answer_id fields required',
                               status_code=400)

        level = K.level_mapping[answer_id[1]]
        score_user(uid, answer_id, level)

        return json.dumps({'success': True}), \
               200, {'ContentType': 'application/json'}


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, ssl_context=('cert.pem', 'key.pem'))
    app.run(ssl_context=('cert.pem', 'key.pem'))  # run on AWS ec2 instnace
