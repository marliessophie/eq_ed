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
              f();
              Navigator.pop(context, button);
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
              fOne();
              Navigator.pop(context, buttonOne);
            },
            child: Text(buttonOne),
          ),
          TextButton(
            onPressed: () {
              fTwo();
              Navigator.pop(context, buttonTwo);
            },
            child: Text(buttonTwo),
          ),
        ],
        elevation: 24.0,
      ),
    );
  }
}
