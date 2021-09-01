import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserData {
  final String? metric, value, description, level;
  final Icon icon;

  UserData(
      {this.level,
      required this.icon,
      this.metric,
      this.value,
      this.description});
}

Future<String> getData(String score) async {
  String _result = '0';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>> value =
      await firestore.collection('user_data').get();

  return _result;
}

List userFilesOne = [
  UserData(
    icon: Icon(
      FontAwesomeIcons.play,
    ),
    metric: 'Number of times begun:',
    value: "51",
    description: "How often a level was initiated.",
    level: 'one',
  ),
  UserData(
    icon: Icon(
      FontAwesomeIcons.bullseye,
    ),
    metric: 'Number of attempts:',
    value: "32",
    description: "How often a level was played, from beginning to end",
    level: 'one',
  ),
  UserData(
    icon: Icon(FontAwesomeIcons.users),
    metric: 'Average communication score:',
    value: '92.3%',
    description:
        "Users average communication score, including successful and failed attempts",
    level: 'one',
  ),
  UserData(
    icon: Icon(FontAwesomeIcons.heart),
    metric: 'Average empathy score:',
    value: "78.8%",
    description:
        "Users average empathy score, including successful and failed attempts",
    level: 'one',
  ),
];

List userFilesTwo = [
  UserData(
    icon: Icon(
      FontAwesomeIcons.play,
    ),
    metric: 'Number of times begun:',
    value: "51",
    description: "How often a level was initiated.",
    level: 'two',
  ),
  UserData(
    icon: Icon(
      FontAwesomeIcons.bullseye,
    ),
    metric: 'Number of attempts:',
    value: "32",
    description: "How often a level was played, from beginning to end",
    level: 'two',
  ),
  UserData(
    icon: Icon(FontAwesomeIcons.users),
    metric: 'Average communication score:',
    value: "68.9%",
    description:
        "Users average communication score, including successful and failed attempts",
    level: 'two',
  ),
  UserData(
    icon: Icon(FontAwesomeIcons.heart),
    metric: 'Average empathy score:',
    value: "68.9%",
    description:
        "Users average empathy score, including successful and failed attempts",
    level: 'two',
  ),
];

List userFilesThree = [
  UserData(
    icon: Icon(
      FontAwesomeIcons.play,
    ),
    metric: 'Number of times begun:',
    value: "51",
    description: "How often a level was initiated.",
    level: 'three',
  ),
  UserData(
    icon: Icon(
      FontAwesomeIcons.bullseye,
    ),
    metric: 'Number of attempts:',
    value: "32",
    description: "How often a level was played, from beginning to end",
    level: 'three',
  ),
  UserData(
    icon: Icon(FontAwesomeIcons.users),
    metric: 'Average communication score:',
    value: "88.9%",
    description:
        "Users average communication score, including successful and failed attempts",
    level: 'three',
  ),
  UserData(
    icon: Icon(FontAwesomeIcons.heart),
    metric: 'Average empathy score:',
    value: "55.6%",
    description:
        "Users average empathy score, including successful and failed attempts",
    level: 'three',
  ),
];
