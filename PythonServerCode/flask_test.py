import json
from flask_app_main import app
import unittest


class FlaskTestCase(unittest.TestCase):

    valid_uid = "LCGt05Hy3UMug6YHQIKNive0GNF2"

    def test_initLevelForUser(self):
        tester = app.test_client(self)

        # Test correct POST api to initiate level.
        response = tester.post('/initLevelForUser', json=({"level_id": "X1000", "uid": self.valid_uid}))
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.get_data(as_text=True))
        self.assertTrue(data['success'])
        self.assertIsNotNone(data['level_narrative'])
        self.assertIsNotNone(data['next_question_id'])

        # Test misspelling of key 'level_id' (invalid json)
        response = tester.post('/initLevelForUser', json=({"levelId": "X1000", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test misspelling of key 'uid' (invalid json)
        response = tester.post('/initLevelForUser', json=({"level_id": "X1000", "UID": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test empty level_id field (invalid json)
        response = tester.post('/initLevelForUser', json=({"level_id": "", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test empty uid field (invalid json)
        response = tester.post('/initLevelForUser', json=({"level_id": "X1000", "uid": ""}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test invalid level_id (valid json, not found error)
        response = tester.post('/initLevelForUser', json=({"level_id": "X1111", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 403)
        self.assertIsNotNone(data['message'])
        self.assertEqual(data['message'], 'Level ID not found.')

    def test_getQuestionResponse(self):
        tester = app.test_client(self)

        # Test correct POST api to get the question response.
        response = tester.post('/getQuestionResponse', json=({"question_id": "X1002", "uid": self.valid_uid}))
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.get_data(as_text=True))
        self.assertTrue(data['success'])
        self.assertIsNotNone(data['question_text'])
        self.assertIsNotNone(data['number_of_answers'])
        self.assertIsNotNone(data['answers'])

        # Test misspelling of key 'question_id' (invalid json)
        response = tester.post('/getQuestionResponse', json=({"questionId": "X1002", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test misspelling of key 'uid' (invalid json)
        response = tester.post('/getQuestionResponse', json=({"question_id": "X1002", "UID": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test empty question_id field (invalid json)
        response = tester.post('/getQuestionResponse', json=({"question_id": "", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test empty uid field (invalid json)
        response = tester.post('/getQuestionResponse', json=({"question_id": "X1002", "uid": ""}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test invalid question_id (valid json, not found error)
        response = tester.post('/getQuestionResponse', json=({"question_id": "X1724", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 403)
        self.assertIsNotNone(data['message'])
        self.assertEqual(data['message'], 'Question ID not found.')

    def test_getLevelEnd(self):
        tester = app.test_client(self)

        # Test correct POST api to get the level end.
        response = tester.post('/getLevelEnd', json=({"question_id": "Z1001", "uid": self.valid_uid}))
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.get_data(as_text=True))
        self.assertTrue(data['success'])
        self.assertIsNotNone(data['question_text'])

        # Test misspelling of key 'question_id' (invalid json)
        response = tester.post('/getLevelEnd', json=({"questionId": "X1000", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test misspelling of key 'uid' (invalid json)
        response = tester.post('/getLevelEnd', json=({"question_id": "X1000", "UID": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test empty question_id field (invalid json)
        response = tester.post('/getLevelEnd', json=({"question_id": "", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test empty uid field (invalid json)
        response = tester.post('/getLevelEnd', json=({"question_id": "X1000", "uid": ""}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test invalid question_id (valid json, not found error)
        response = tester.post('/getLevelEnd', json=({"question_id": "X1111", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 403)
        self.assertIsNotNone(data['message'])
        self.assertEqual(data['message'], 'Level ID not found.')

    def test_scoreUser(self):
        tester = app.test_client(self)

        # Test correct POST api to get the score the user. ["uid", "answer_id"]
        response = tester.post('/scoreUser', json=({"answer_id": "Y1001", "uid": self.valid_uid}))
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.get_data(as_text=True))
        self.assertTrue(data['success'])

        # Test misspelling of key 'answer_id' (invalid json)
        response = tester.post('/scoreUser', json=({"answerId": "Y1001", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test misspelling of key 'uid' (invalid json)
        response = tester.post('/scoreUser', json=({"answer_id": "Y1001", "UID": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test empty answer_id field (invalid json)
        response = tester.post('/scoreUser', json=({"answer_id": "", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test empty uid field (invalid json)
        response = tester.post('/scoreUser', json=({"answer_id": "Y1001", "uid": ""}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 400)
        self.assertIsNotNone(data['message'])
        self.assertTrue('Invalid json format' in data['message'])

        # Test invalid answer_id (valid json, not found error)
        response = tester.post('/scoreUser', json=({"answer_id": "X1111", "uid": self.valid_uid}))
        data = json.loads(response.get_data(as_text=True))
        self.assertEqual(response.status_code, 403)
        self.assertIsNotNone(data['message'])
        self.assertEqual(data['message'], 'Answer ID not found.')
