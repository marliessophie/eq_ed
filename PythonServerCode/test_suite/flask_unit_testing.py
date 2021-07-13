import json
import unittest
from PythonServerCode.flask_app_main import app


class FlaskTestCase(unittest.TestCase):

    def test_catchupInit(self):
        tester = app.test_client(self)

        # # Test correct POST api to initiate catchup.
        # response = tester.post('/catchupInit', json={"groupID": "G5"})
        # self.assertEqual(response.status_code, 200)
        # data = json.loads(response.get_data(as_text=True))
        # self.assertTrue(data['success'])
        # self.assertIsNotNone(data['newCatchupID'])
        #
        # # Test misspelling of key 'groupID' (invalid json)
        # response = tester.post('/catchupInit', json={"groupid": "G5"})
        # data = json.loads(response.get_data(as_text=True))
        # self.assertEqual(response.status_code, 400)
        # self.assertIsNotNone(data['message'])
        # self.assertTrue('Invalid json format' in data['message'])
        #
        # # Test misspelling of key 'groupID' (invalid json)
        # response = tester.post('/catchupInit', json={"group_id": "G5"})
        # data = json.loads(response.get_data(as_text=True))
        # self.assertEqual(response.status_code, 400)
        # self.assertIsNotNone(data['message'])
        # self.assertTrue('Invalid json format' in data['message'])
        #
        # # Test non-existent groupID (valid json, not found error)
        # response = tester.post('/catchupInit', json={"groupID": "G"})
        # data = json.loads(response.get_data(as_text=True))
        # print(data)
        # self.assertEqual(response.status_code, 403)
        # self.assertIsNotNone(data['message'])
        # self.assertEqual(data['message'], 'Group ID not found')
        #
        # # Test empty groupID field (invalid json)
        # response = tester.post('/catchupInit', json={"groupID": ""})
        # data = json.loads(response.get_data(as_text=True))
        # self.assertEqual(response.status_code, 400)
        # self.assertIsNotNone(data['message'])
        # self.assertTrue('Invalid json format' in data['message'])

    def test_catchupCountVotes(self):
        tester = app.test_client(self)

        # # Invalid json. catchupID required.
        # response = tester.post('/catchupCountVotes', json={"groupID": "G5"})
        # self.assertEqual(response.status_code, 400)
        # data = json.loads(response.get_data(as_text=True))
        # print(data)
        # self.assertIsNotNone(data['message'])
        # self.assertTrue('Invalid json format' in data['message'])
        #
        # # Invalid json.
        # response = tester.post('/catchupCountVotes', json={"catchupID": ""})
        # self.assertEqual(response.status_code, 400)
        # data = json.loads(response.get_data(as_text=True))
        # print(data)
        # self.assertIsNotNone(data['message'])
        # self.assertTrue('Invalid json format' in data['message'])
        #
        # # Correct usage:
        # response = tester.post('/catchupCountVotes', json={"catchupID": "C333"})
        # self.assertEqual(response.status_code, 200)
        # data = json.loads(response.get_data(as_text=True))
        # print('return json')
        # print(data)
        # self.assertTrue(data['success'])
        # self.assertIsNotNone(data['WinnerID'])
        #
        # # Group already had votes counted:
        # response = tester.post('/catchupCountVotes', json={"catchupID": "C333"})
        # self.assertEqual(response.status_code, 403)
        # data = json.loads(response.get_data(as_text=True))
        # print('return json')
        # print(data)
        # self.assertIsNotNone(data['message'])
        # self.assertEqual(data['message'], 'Catchup already had votes counted!')


if __name__ == '__main__':
    unittest.main()
