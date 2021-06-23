import 'package:eq_ed/screens/email_login_screen.dart';
import 'package:eq_ed/screens/home_screen.dart';
import 'package:eq_ed/screens/info_screen.dart';
import 'package:eq_ed/screens/register_screen.dart';
import 'package:eq_ed/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    WelcomeScreen.id: (context) => WelcomeScreen(),
    HomeScreen.id: (context) => HomeScreen(),
    RegisterScreen.id: (context) => RegisterScreen(),
    EmailLoginScreen.id: (context) => EmailLoginScreen(),
    InfoScreen.id: (context) => InfoScreen()
  };
}
