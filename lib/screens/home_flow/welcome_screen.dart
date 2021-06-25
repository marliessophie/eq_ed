import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:eq_ed/components/game_navigation_components/firebase_service.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/login_flow/email_login_screen.dart';
import 'package:eq_ed/screens/home_flow/info_screen.dart';
import 'package:eq_ed/screens/login_flow/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class WelcomeScreen extends StatefulWidget {
  static var id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Hi, I\'m EQ\'ed!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'Sign-in below.',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 18.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Who is EQ\'ed?',
                        style: kNormalTextStyle.copyWith(
                          fontSize: 15.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, InfoScreen.id);
                        },
                        child: Text(
                          'Find out more about me!',
                          style: kNormalTextStyle.copyWith(
                            color: kSecondaryAccentColor,
                            fontSize: 15.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: AnimatedImage(),
          ),
          Expanded(
            child: ReusableCard(
              cardChild: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: SignInButton(
                        Buttons.Google,
                        text: "Connect via Google",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () async {
                          FirebaseService service = new FirebaseService();
                          try {
                            await service.signInwithGoogle();
                            // TODO: include navigator and check playstore connection
                            // Navigator.pushNamedAndRemoveUntil(context, Constants.homeNavigate, (route) => false);
                          } catch (e) {
                            if (e is FirebaseAuthException) {
                              showMessage(e.message!);
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: SignInButton(
                        Buttons.Facebook,
                        text: "Connect via Facebook",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: SignInButton(
                        Buttons.Twitter,
                        text: "Connect via Twitter",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: SignInButton(
                        Buttons.Email,
                        text: "Sign in via Email",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, EmailLoginScreen.id);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              onPress: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account?',
                  style: kNormalTextStyle.copyWith(
                    fontSize: 18.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                  child: Text(
                    'Sign Up!',
                    style: kNormalTextStyle.copyWith(
                      color: kAccentColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TODO: refactor alters to single class throughtout app
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
