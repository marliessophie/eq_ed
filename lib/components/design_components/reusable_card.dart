import 'package:eq_ed/constants.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {this.colour = Colors.white54,
      this.borderColor = Colors.white54,
      required this.cardChild,
      required this.onPress});

  final Color colour;
  final Widget cardChild;
  final VoidCallback onPress;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: kActiveCardColour,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
        ),
        height: 50.0,
      ),
    );
  }
}
