import 'dart:async';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// TODO: add formatting to the UI

class VerifyScreen extends StatefulWidget {
  static var id = 'verify_screen';

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    sendUserVerification();
    super.initState();
  }

  void sendUserVerification() async {
    try {
      user = (await _auth.currentUser)!;
      user.sendEmailVerification();
      timer = Timer.periodic(
          Duration(
            seconds: 3,
          ),
          (timer) {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkEmailVerified() async {
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.pushNamed(context, HomeScreen.id);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed'),
      ),
      body: Text(
          'An email has been sent to ${user.email}, please verify. As soon as you have verified your email, you will be taken to the home screen.'),
    );
  }
}
