import 'package:eq_ed/components/game_navigation_components/navigate.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_flow/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// TODO: work on interaction with back-end API endpoints >> build model (do research)
/* TODO: change score display for users, as second screen to come up
    when the user presses on their level, to see a description of the current level, and score split */
// TODO: include graphical representation of actual snowballs / badges that users get while enhancing

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        colorScheme: ColorScheme.fromSwatch().copyWith(),
      ),
      initialRoute: WelcomeScreen.id,
      routes: Navigate.routes,
    );
  }
}
