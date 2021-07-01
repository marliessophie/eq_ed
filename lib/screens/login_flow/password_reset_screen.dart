import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  static var id = 'password_reset_screen';

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  late String _email;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Email Verification'),
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
                    'Please type your email \naddress below!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'We will send you a link for the password reset.',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 15.0,
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
                          _email = value;
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
                    Expanded(
                      child: ReusableCard(
                        cardChild: Center(
                            child: Text('Send email!',
                                style: kLabelTextStyle.copyWith(
                                  color: Colors.white,
                                ))),
                        onPress: () {
                          _auth.sendPasswordResetEmail(email: _email);
                          Navigator.pop(context);
                        },
                        colour: kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }
}
