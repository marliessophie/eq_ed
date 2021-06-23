import 'package:eq_ed/components/navigate.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
