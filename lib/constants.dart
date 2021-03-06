import 'package:flutter/material.dart';

// colors
const kBottomContainerHeight = 80.0;
const kAppBarColor = Color(0xFF1D1E33);
const kPrimaryColor = Color(0xFF00796B);
const kSecondaryColor = Color(0xFFCDDC39);
const kLightColor = Color(0xFFB2DFDB);
const kAccentColor = Color(0xFFE91E63);
const kAccentTransparent = Color(0x29E91E63);
const kSecondaryAccentColor = Color(0xFF7B1FA2);
const kActiveCardColour = Color(0xFFEEE2DA); // 1A1D1E33
const kInactiveCardColour = Colors.white;
final List<Color> kGradientColorsEQed = [kLightColor, kAppBarColor];
final List<Color> kGradientColorsScore = [kLightColor, kPrimaryColor];

// text styles
const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const kNormalTextStyle = TextStyle(
  fontSize: 18.0,
  color: kAppBarColor,
);

const kPlaceholderTextStyle = TextStyle(
  fontSize: 16.0,
  color: Color(0xFF757575),
);

const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kBMITextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);

// variables
final Function onPressed = () {};

// api endpoints
const String kLevelEnd = 'http://13.58.218.236:5000/getLevelEnd';
const String kGetQuestionResponse =
    'http://13.58.218.236:5000/getQuestionResponse';
const String kInitLevel = 'http://13.58.218.236:5000/initLevelForUser';
const String kScoreUser = 'http://13.58.218.236:5000/scoreUser';

// game data
const String kLevelId1 = 'X1000';
const String kLevelId2 = 'X2000';
const String kLevelId3 = 'X3000';
const String kQuestionId1 = 'X1001';
const String kQuestionId2 = 'X2001';
const String kQuestionId3 = 'X3001';
