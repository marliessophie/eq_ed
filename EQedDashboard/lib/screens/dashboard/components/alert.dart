import 'package:flutter/material.dart';

class UserAlert {
  static void showMessageOneButton(BuildContext context, String heading,
      String text, String button, Function f) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(heading),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, button);
              f();
            },
            child: Text(button),
          ),
        ],
        elevation: 24.0,
      ),
    );
  }

  static void showMessageTwoButtons(
      BuildContext context,
      String heading,
      String text,
      String buttonOne,
      String buttonTwo,
      Function fOne,
      Function fTwo) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(heading),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, buttonOne);
              fOne();
            },
            child: Text(buttonOne),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, buttonTwo);
              fTwo();
            },
            child: Text(buttonTwo),
          ),
        ],
        elevation: 24.0,
      ),
    );
  }
}
