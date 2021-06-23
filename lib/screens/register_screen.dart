import 'package:eq_ed/components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_screen.dart';
import 'package:eq_ed/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: include the name of the user in the cloud database

class RegisterScreen extends StatefulWidget {
  static var id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool showSpinner = false;
  late String userName;
  late String email;
  late String password;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed'),
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
                            userName = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter name",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kAccentColor),
                            ),
                          ),
                          style: kPlaceholderTextStyle.copyWith(
                              fontStyle: FontStyle.italic),
                        ),
                      ),
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
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              // TODO: adjust this to more recent syntax
                              if (newUser != null) {
                                loggedInUser = newUser.user!;
                                // Add userName to the FirebaseFirestore
                                _firestore
                                    .collection('user_data')
                                    .doc(loggedInUser.uid)
                                    .set({
                                  'user_name': userName,
                                  'score': 0,
                                });
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
