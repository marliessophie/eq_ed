import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/components/game_navigation_components/scorer.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/game_flow/scenario_screen.dart';
import 'package:eq_ed/screens/home_flow/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static var id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  String userName = 'friend';
  int score = 0;
  String level = 'ice queen';

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
        print(loggedInUser.uid);
        _firestore
            .collection('user_data')
            .doc(loggedInUser.uid)
            .get()
            .then((DocumentSnapshot value) {
          if (value.exists) {
            setState(() {
              userName = value['user_name'].toString();
              score = value['score'].toInt();
              level = Scorer.getLevel(score);
            });
          }
        });
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) {
                return route.settings.name == WelcomeScreen.id;
              });
            },
          )
        ],
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
                    'Welcome back $userName!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 15.0),
              child: ReusableCard(
                cardChild: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Text('Your score: $score ice cubes',
                            style: kNormalTextStyle),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child:
                            Text('Your level: $level', style: kNormalTextStyle),
                      ),
                      SizedBox(
                        height: 70.0,
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
                            Navigator.pushNamed(context, ScenarioScreen.id);
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
          ),
        ],
      ),
    );
  }
}