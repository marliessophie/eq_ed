import 'package:flutter/material.dart';
import '../../constants.dart';

class IconContent extends StatelessWidget {
  IconContent({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: IconTheme(
            data: IconThemeData(color: kAppBarColor),
            child: Icon(
              icon,
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Expanded(
          child: Text(
            label,
            style: kLabelTextStyle.copyWith(
              color: kAppBarColor,
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}
