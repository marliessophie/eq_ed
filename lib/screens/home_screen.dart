import 'package:eq_ed/components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// TODO: include the users name dynamic from firebase instance

class HomeScreen extends StatefulWidget {
  static var id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
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
        title: Text('EQ\'ed | Home'),
        automaticallyImplyLeading: false,
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
                    'Welcome back, Sarah!',
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
                      child: Text('Your score: XX ice cubes',
                          style: kNormalTextStyle),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Text('Your level: ice queen',
                          style: kNormalTextStyle),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kPrimaryColor,
                        cardChild: Center(
                          child: Text(
                            'Start a new game!',
                            style: kLabelTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPress: () {
                          // TODO: change this to game screen
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
        ],
      ),
    );
  }
}
