import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future<Map> apiRequestInitLevel(String url, Map data) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: convert.jsonEncode(data),
  );
  Map result;
  if (response.statusCode == 200) {
    var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    result = {
      "levelNarrative": jsonData['level_narrative'],
      "nextQuestionId": jsonData['next_question_id'],
    };
  } else {
    return result = {
      "levelNarrative": 'Placeholder',
      "nextQuestionId": 'Error 400',
    }; // todo - raise exception here
  }
  return result;
}

Future<Map> apiRequestGetQuestion(String url, Map data) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: convert.jsonEncode(data),
  );
  Map result;
  if (response.statusCode == 200) {
    print(response.body);
    var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    result = {
      "questionText": jsonData['question_text'],
      "answers": jsonData['answers'],
      "numberOfAnswers": jsonData['number_of_answers']
    };
  } else {
    return result = {
      "questionText": 'Placeholder',
    }; // todo - raise exception here
  }
  return result;
}

Future<Map> apiRequestLevelEnd(String url, Map data) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: convert.jsonEncode(data),
  );
  Map result;
  if (response.statusCode == 200) {
    var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    result = {
      "questionText": jsonData['question_text'],
      "nextQuestionId": jsonData['next_question_id'],
    };
  } else {
    return result = {
      "questionText": 'Placeholder',
      "nextQuestionId": 'Error 400',
    }; // todo - raise exception here
  }
  return result;
}
