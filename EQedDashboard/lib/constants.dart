import 'package:flutter/material.dart';

// colors
const kPrimaryColor = Color(0xFFCDDC39);
const kSecondaryColor = Color(0xFF2A2D3E);
const kBgColor = Color(0xFF212332);

// padding
const kDefaultPadding = 16.0;

// function
final Function onPressed = () {};

class Category {
  Category(this.name, {required this.amount});

  final String name;
  final double amount;
}

final kCategories = [
  Category('Completed', amount: 500.00),
  Category('Failed', amount: 150.00),
];

final kNeumorphicColors = [
  Color(0xFFCDDC39),
  Color.fromRGBO(46, 198, 255, 1), // rgb(46, 198, 255)
];
