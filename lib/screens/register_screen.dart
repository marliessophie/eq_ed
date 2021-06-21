import 'package:eq_ed/components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_screen.dart';
import 'package:eq_ed/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// TODO: include the name of the user in the cloud database

class RegisterScreen extends StatefulWidget {
  static var id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  void initState() {
    super.initState();
  }

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
                    'Please Sign Up below!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
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
                          // TODO: firebase auth link and error messages for user
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
                      child: ReusableCard(
                        colour: kPrimaryColor,
                        cardChild: Center(
                          child: Text(
                            'Get started!',
                            style: kLabelTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPress: () async {
                          // TODO: insert checks for password & email
                          // TODO: connect to firebase and add new user
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              // TODO: adjust this to more recent syntax
                              Navigator.pushNamed(context, HomeScreen.id);
                            }
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
    );
  }
}
