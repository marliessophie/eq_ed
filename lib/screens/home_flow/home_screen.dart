import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eq_ed/components/design_components/alert.dart';
import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:eq_ed/components/design_components/icon_content.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/components/game_navigation_components/scorer.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/models/server_api.dart';
import 'package:eq_ed/screens/game_flow/level_screen.dart';
import 'package:eq_ed/screens/game_flow/scenario_screen.dart';
import 'package:eq_ed/screens/home_flow/score_details_screen.dart';
import 'package:eq_ed/screens/home_flow/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

// TODO: build separate screen for score details (possibly benchmark against analytics)

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
  double cp = 0;
  double ep = 0;
  String level = 'ice queen';
  int attempts = 0;
  String score = '0';
  int index = 0;

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
              attempts = value['attempts'];
              // todo - need to think about how to get all the scores, and show per level (get the average)
              // int empathyScore = value['empathy_score'].toInt();
              // int communicationScore = value['communication_score'].toInt();
              score = attempts.toString();
              level = Scorer.getLevel(attempts.toInt());
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
              var signOut = () {
                _auth.signOut();
                Navigator.of(context).popUntil((route) {
                  return route.settings.name == WelcomeScreen.id;
                });
              };
              UserAlert.showMessageTwoButtons(
                  context,
                  'Logout',
                  'Are you sure you want to logout?',
                  'NO',
                  'YES',
                  onPressed,
                  signOut);
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
            if (i == 1) {
              UserAlert.showMessageOneButton(
                  context,
                  'Not available',
                  'Our development team is working hard to release this feature, please be patient.',
                  'OK',
                  onPressed);
            }
          });
        },
      ),
      //),
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
                  Expanded(
                    child: AnimatedImage(),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Your score: $score ice cubes',
                                      style: kNormalTextStyle.copyWith(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Your level: $level',
                                      style: kNormalTextStyle.copyWith(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ReusableCard(
                                onPress: () {
                                  Navigator.pushNamed(
                                      context, ScoreDetailsScreen.id);
                                },
                                colour: kSecondaryColor,
                                cardChild: IconContent(
                                  icon: FontAwesomeIcons.search,
                                  label: 'Score Details',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ReusableCard(
                        colour: kPrimaryColor,
                        cardChild: Center(
                          child: Text(
                            'Start playing!',
                            style: kLabelTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPress: () {
                          Navigator.pushNamed(context, LevelScreen.id);
                        },
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
