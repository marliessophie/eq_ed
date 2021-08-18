import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eq_ed/components/game_navigation_components/scorer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

enum ScoreType {
  empathy,
  communication,
}

class ScoreDetailsScreen extends StatefulWidget {
  static var id = 'score_details_screen';

  @override
  _ScoreDetailsScreenState createState() => _ScoreDetailsScreenState();
}

class _ScoreDetailsScreenState extends State<ScoreDetailsScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  int score = 0;
  String attempts = '';
  var empathyScore = ['0', '0', '0'];
  var communicationScore = ['0', '0', '0'];
  String level = 'ice queen';
  final String notCompleted = '0, level not completed.';

  String getScore(ScoreType type, int index) {
    return type == ScoreType.empathy
        ? empathyScore[index]
        : communicationScore[index];
  }

  void extractScores(scoreValues, String level, int index) {
    if (scoreValues[level] != null) {
      var scoreOne = scoreValues[level];
      setState(() {
        empathyScore[index] = scoreOne['final_ep_percentage'].toString();
        communicationScore[index] = scoreOne['final_cp_percentage'].toString();
      });
    } else {
      setState(() {
        empathyScore[index] = notCompleted;
        communicationScore[index] = notCompleted;
      });
    }
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
            print('success');
            setState(() {
              if (value['attempts'] != null) {
                // this should always be true
                score = value['attempts'];
                attempts = attempts.toString();
                level = Scorer.getLevel(score);
              }
              if (value['final_scores'] != null) {
                var scoreValues = value['final_scores'];
                // check for one
                extractScores(scoreValues, 'one', 0);
                // check for two
                extractScores(scoreValues, 'two', 1);
                // check for three
                extractScores(scoreValues, 'three', 2);
              }
            });
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-EQ'ed",
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: kGradientColorsScore,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.close),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                      tag: "image-EQ'ed",
                      child: Image.asset('images/penguin2.png',
                          height: screenHeight * 0.35)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Hero(
                    tag: "name-EQ'ed",
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        child: Text(
                          'Your score details',
                          style: kLabelTextStyle.copyWith(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total attempts: $score",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 22.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Level 1",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 22.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        "  Empathy score: ${getScore(ScoreType.empathy, 0)}",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        "  Communication score: ${getScore(ScoreType.communication, 0)}",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Level 2",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 22.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        "  Empathy score: ${getScore(ScoreType.empathy, 1)}",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        "  Communication score: ${getScore(ScoreType.communication, 1)}",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Level 3",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 22.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        "  Empathy score: ${getScore(ScoreType.empathy, 2)}",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        "  Communication score: ${getScore(ScoreType.communication, 2)}",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Your level $level means " +
                            Scorer.getLevelDescription(score),
                        style: kLabelTextStyle.copyWith(
                          fontSize: 22.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
