from flask import Flask, request, jsonify
import ast
import json
import jsonschema
from jsonschema import validate
import datetime
import pandas as pd
import pickle
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
"""
json file to send: 
{
    "level_id": "User1",
    "uid":"G3"
}
"""
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

        level_narrative = 'This is the level'# get_level_narrative(level_id)
        # TODO: define json schema detailing the return to the UI in conjuction with firebase
        # TODO: need to return next question id as well

        return json.dumps({'success': True, 'level_narrative': level_narrative}), \
               200, {'ContentType': 'application/json'}


'''
@app.route('/catchupInitWithHost', methods=['POST'])
def main_catchupInitWithHost_post():
    with open('schema_catchupInitWithHost_post.json') as sch_init:
        sch_init = json.load(sch_init)

    jsonData = request.get_json()
    print(jsonData)
    if not validateJson(jsonData, sch_init):
        raise InvalidUsage('Invalid json format. groupID and hostuserID fields required',
                           status_code=400)

    # print('valid json')
    print(f'json received is: {jsonData}')
    groupIDReq = jsonData['groupID']
    hostIDReq = jsonData['hostuserID']

    # Run Recommender System Model to generate shortlist of restaurants
    newCatchupID = createNewCatchup(groupIDReq, numRecommendation=20, hostuserID=hostIDReq)

    return json.dumps({'success': True, 'newCatchupID': newCatchupID}), \
           200, {'ContentType': 'application/json'}

@app.route('/catchupCountVotes', methods=['POST'])
def main_catchupCountVotes():
    with open('schema_catchupCountVotes_post.json') as sch_count_votes:
        sch_count_votes = json.load(sch_count_votes)

    jsonData = request.get_json()

    if not validateJson(jsonData, sch_count_votes):
        raise InvalidUsage(r'Invalid json format. catchupID field required',
                           status_code=400)

    # print('valid json')
    print(jsonData)
    catchupID = jsonData['catchupID']
    winnerID = callVoteOnCatchup(catchupID)

    return json.dumps({'success': True, 'WinnerID': winnerID}), \
           200, {'ContentType': 'application/json'}
'''

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)  # TODO: AWS connection
    # app.run()
    # app.run(debug=True, port=9090)
