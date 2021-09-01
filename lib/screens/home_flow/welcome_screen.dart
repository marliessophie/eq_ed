import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:eq_ed/screens/login_flow/email_login_screen.dart';
import 'package:eq_ed/screens/home_flow/info_screen.dart';
import 'package:eq_ed/screens/login_flow/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatefulWidget {
  static var id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final googleSignIn = GoogleSignIn();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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
          Padding(
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
          Expanded(
            child: Center(child: AnimatedImage()),
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
                          final user = await googleSignIn.signIn();
                          if (user != null) {
                            final googleAuth = await user.authentication;
                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth.accessToken,
                              idToken: googleAuth.idToken,
                            );
                            await _auth.signInWithCredential(credential);
                            try {
                              final user = await _auth.currentUser;
                              if (user != null) {
                                _firestore
                                    .collection('user_data')
                                    .doc(user.uid)
                                    .get()
                                    .then((DocumentSnapshot value) {
                                  if (!value.exists) {
                                    // add user to the database as this is the first login ever
                                    _firestore
                                        .collection('user_data')
                                        .doc(user.uid)
                                        .set({
                                      'user_name': user.displayName,
                                      'attempts': 0,
                                    });
                                  }
                                });
                              }
                            } catch (e) {
                              print(e);
                            }
                            // move to home screen
                            Navigator.pushNamed(context, HomeScreen.id);
                          }
                        },
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
          Expanded(
            child: Padding(
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
          ),
        ],
      ),
    );
  }

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
