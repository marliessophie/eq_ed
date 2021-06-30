import 'package:eq_ed/screens/game_flow/answer_screen.dart';
import 'package:eq_ed/screens/game_flow/example_answer_screen.dart';
import 'package:eq_ed/screens/game_flow/feedback_screen.dart';
import 'package:eq_ed/screens/game_flow/played_scenarios_screen.dart';
import 'package:eq_ed/screens/game_flow/scenario_screen.dart';
import 'package:eq_ed/screens/home_flow/info_details_screen.dart';
import 'package:eq_ed/screens/login_flow/email_login_screen.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:eq_ed/screens/home_flow/info_screen.dart';
import 'package:eq_ed/screens/login_flow/register_screen.dart';
import 'package:eq_ed/screens/home_flow/welcome_screen.dart';
import 'package:eq_ed/screens/login_flow/verify_screen.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    WelcomeScreen.id: (context) => WelcomeScreen(),
    HomeScreen.id: (context) => HomeScreen(),
    RegisterScreen.id: (context) => RegisterScreen(),
    EmailLoginScreen.id: (context) => EmailLoginScreen(),
    InfoScreen.id: (context) => InfoScreen(),
    AnswerScreen.id: (context) => AnswerScreen(),
    FeedbackScreen.id: (context) => FeedbackScreen(),
    ScenarioScreen.id: (context) => ScenarioScreen(),
    PlayedScenariosScreen.id: (context) => PlayedScenariosScreen(),
    InfoDetailsScreen.id: (context) => InfoDetailsScreen(),
    VerifyScreen.id: (context) => VerifyScreen(),
  };
}
