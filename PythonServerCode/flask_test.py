import json
from flask_app_main import app
import unittest


class FlaskTestCase(unittest.TestCase):

    def test_initLevelForUser(self):
        tester = app.test_client(self)

        # Test correct POST api to initiate level.
        response = tester.post('/initLevelForUser', json=({"level_id": "X1000", "uid": "User1"}))
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.get_data(as_text=True))
        self.assertTrue(data['success'])
        self.assertIsNotNone(data['level_narrative'])
        self.assertIsNotNone(data['next_question_id'])

        # # Test misspelling of key 'level_id' (invalid json)
        # # Test misspelling of key 'uid' (invalid json)
        # # Test empty level_id field (invalid json)
        # todo - think of testing invalid user id (valid json, not found error)
        # response = tester.post('/catchupInit', json={"groupID": "G"})
        # data = json.loads(response.get_data(as_text=True))
        # print(data)
        # self.assertEqual(response.status_code, 403)
        # self.assertIsNotNone(data['message'])
        # self.assertEqual(data['message'], 'Group ID not found')

    def test_getQuestionResponse(self):
        tester = app.test_client(self)

        # Test correct POST api to get the question response.
        response = tester.post('/getQuestionResponse', json=({"question_id": "X1002", "uid": "User1"}))
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.get_data(as_text=True))
        self.assertTrue(data['success'])
        self.assertIsNotNone(data['question_text'])
        self.assertIsNotNone(data['number_of_answers'])
        self.assertIsNotNone(data['answers'])

    def test_getLevelEnd(self):
        tester = app.test_client(self)

        # Test correct POST api to get the level end.
        response = tester.post('/getLevelEnd', json=({"question_id": "Z1001", "uid": "User1"}))
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.get_data(as_text=True))
        self.assertTrue(data['success'])
        self.assertIsNotNone(data['question_text'])
