import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eq_ed/components/design_components/alert.dart';
import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/screens/game_flow/scenario_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class LevelScreen extends StatefulWidget {
  static var id = 'level_screen';
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  final _auth = FirebaseAuth.instance;
  String uid = "User1";
  List<bool> completedLevels = [true, false, false];
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkLevel();
  }

  // check against db if the user has passed this level
  void checkLevel() async {
    try {
      final user = await _auth.currentUser; // todo - fix this
      if (user != null) {
        uid = user.uid;
      }
    } catch (e) {
      print(e);
    }
    _firestore
        .collection('user_data')
        .doc(uid)
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        // check if user has completed level 1 and 2
        if (value['final_scores'] != null) {
          var scoreValues = value['final_scores'];
          if (scoreValues['one'] != null) {
            setState(() {
              completedLevels[1] = true;
            });
          }
          if (scoreValues['two'] != null) {
            setState(() {
              completedLevels[2] = true;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Levels'),
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
                    'Game time!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'Select a level to play below.',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 18.0,
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
                        child: ReusableCard(
                          colour: kPrimaryColor,
                          cardChild: Center(
                            child: Text(
                              'Level one',
                              style: kLabelTextStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScenarioScreen(
                                  levelId: kLevelId1,
                                  questionId: kQuestionId1,
                                ),
                              ),
                            );
                            widget._analytics
                                .logEvent(name: 'level_1', parameters: null);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ReusableCard(
                          colour: completedLevels[1]
                              ? kPrimaryColor
                              : kActiveCardColour,
                          cardChild: Center(
                            child: Text(
                              'Level two',
                              style: kLabelTextStyle.copyWith(
                                color: completedLevels[1]
                                    ? Colors.white
                                    : kAppBarColor,
                              ),
                            ),
                          ),
                          onPress: () {
                            // todo - include check if the user has completed the previous level
                            if (completedLevels[1]) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScenarioScreen(
                                    levelId: kLevelId2,
                                    questionId: kQuestionId2,
                                  ),
                                ),
                              );
                              widget._analytics
                                  .logEvent(name: 'level_2', parameters: null);
                            } else {
                              UserAlert.showMessageOneButton(
                                  context,
                                  'Not unlocked yet 😲',
                                  'You have not completed the previous levels. To unlock this level, please complete level 1 🤩',
                                  'OK',
                                  onPressed);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Expanded(
                        child: ReusableCard(
                          colour: completedLevels[2]
                              ? kPrimaryColor
                              : kActiveCardColour,
                          cardChild: Center(
                            child: Text(
                              'Level three',
                              style: kLabelTextStyle.copyWith(
                                color: completedLevels[2]
                                    ? Colors.white
                                    : kAppBarColor,
                              ),
                            ),
                          ),
                          onPress: () {
                            if (completedLevels[2]) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScenarioScreen(
                                    levelId: kLevelId3,
                                    questionId: kQuestionId3,
                                  ),
                                ),
                              );
                              widget._analytics
                                  .logEvent(name: 'level_3', parameters: null);
                            } else {
                              UserAlert.showMessageOneButton(
                                  context,
                                  'Not unlocked yet 😲',
                                  'You have not completed the previous levels. To unlock this level, please complete level 2 🤩',
                                  'OK',
                                  onPressed);
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
          ),
          SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
