import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/components/design_components/alert.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:eq_ed/screens/home_flow/info_screen.dart';
import 'package:eq_ed/screens/login_flow/password_reset_screen.dart';
import 'package:eq_ed/screens/login_flow/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EmailLoginScreen extends StatefulWidget {
  static var id = 'email_login_screen';

  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Login'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
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
                      'Please Sign In below!',
                      style: kNormalTextStyle.copyWith(
                        fontSize: 30.0,
                      ),
                    ),
                    Container(
                      child: AnimatedImage(),
                      height: 250.0,
                    ),
                  ],
                ),
              ),
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
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter email",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kAccentColor),
                            ),
                          ),
                          style: kPlaceholderTextStyle.copyWith(
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter password",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kAccentColor),
                            ),
                          ),
                          style: kPlaceholderTextStyle.copyWith(
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      TextButton(
                        child: Text('Forgot password?',
                            style: kNormalTextStyle.copyWith(
                              color: kAccentColor,
                              fontSize: 15.0,
                            )),
                        onPressed: () {
                          var moveToResetScreen = () {
                            Navigator.pushNamed(
                                context, PasswordResetScreen.id);
                          };
                          UserAlert.showMessageTwoButtons(
                              context,
                              'Password Reset',
                              'Are you sure you would like to reset your password?',
                              'NO',
                              'YES',
                              onPressed,
                              moveToResetScreen);
                        },
                      ),
                      Expanded(
                        child: ReusableCard(
                          colour: kPrimaryColor,
                          cardChild: Center(
                            child: Text(
                              'Login',
                              style: kLabelTextStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPress: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Navigator.pushNamed(context, HomeScreen.id);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
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
                    'Who is EQ\'ed?',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 18.0,
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
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
