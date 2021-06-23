import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

// TODO: check if screen is actually needed

class LoginScreen extends StatefulWidget {
  static var id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              child: Text(
                'Good to see you! \nPlease sign-in below.',
                style: kNormalTextStyle.copyWith(
                  fontSize: 30.0,
                ),
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
                      child: SignInButton(
                        Buttons.Google,
                        text: "Sign up with Google",
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
                        Buttons.Facebook,
                        text: "Sign up with Facebook",
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
                        text: "Sign up with Twitter",
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
                        text: "Sign up with Email",
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {},
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
        ],
      ),
    );
  }
}
