import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future<Map> apiRequestInitLevel(String url, Map data) async {
  // todo - replace with Future<String>
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
  print(convert.jsonDecode(response.body));
  // todo - you should check the response.statusCode
  //   String reply = await response.transform(utf8.decoder).join();
  // return jsonDecode(response.body);
}

// Future getData(url) async {
//   // Await the http get response, then decode the json-formatted response.
//   print("The url");
//   print(url);
//   var response = await http.get(url, headers: {
//     "Access-Control-Allow-Origin": "*", // Required for CORS support to work
//     "Access-Control-Allow-Credentials":
//         "true", // Required for cookies, authorization headers with HTTPS
//     "Access-Control-Allow-Headers":
//         "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
//     "Access-Control-Allow-Methods": "POST, OPTIONS"
//   });
//
//   if (response.statusCode == 200) {
//     var jsonResponse =
//         convert.jsonDecode(response.body) as Map<String, dynamic>;
//     var query = jsonResponse['summary'];
//     print('Query: $query.');
//     return query;
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
//   print(response.body);
//   return null;
// }
//
// Future getResponse(url) {
//   // var returnResponse;
//   var response = getData(url); //.then((value) => {returnResponse = value});
//   return response;
// }
//
// Future getResponseJson(url) {
//   // var returnResponse;
//   var response = getJson(url); //.then((value) => {returnResponse = value});
//   return response;
// }
//
// Future getJson(url) async {
//   // Await the http get response, then decode the json-formatted response.
//   print("The url");
//   print(url);
//   var response = await http.get(url, headers: {
//     "Access-Control-Allow-Origin": "*", // Required for CORS support to work
//     "Access-Control-Allow-Credentials":
//         "true", // Required for cookies, authorization headers with HTTPS
//     "Access-Control-Allow-Headers":
//         "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
//     "Access-Control-Allow-Methods": "POST, OPTIONS"
//   });
//
//   if (response.statusCode == 200) {
//     var jsonResponse =
//         convert.jsonDecode(response.body) as Map<String, dynamic>;
//     print('Response: $jsonResponse.');
//     return jsonResponse;
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
//   print(response.body);
//   return null;
// }
