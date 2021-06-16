import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/email_login_screen.dart';
import 'package:eq_ed/screens/home_screen.dart';
import 'package:eq_ed/screens/info_screen.dart';
import 'package:eq_ed/screens/login_screen.dart';
import 'package:eq_ed/screens/register_screen.dart';
import 'package:eq_ed/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EQed());
}

class EQed extends StatelessWidget {
  const EQed({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EQ\'ed',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kAccentColor,
          selectionColor: kAccentTransparent,
          selectionHandleColor: kAccentTransparent,
        ),
        // primaryColor: kAccentColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(),
        // backgroundColor: Colors.orange,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        // LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        EmailLoginScreen.id: (context) => EmailLoginScreen(),
        InfoScreen.id: (context) => InfoScreen(),
      },
    );
  }
}
