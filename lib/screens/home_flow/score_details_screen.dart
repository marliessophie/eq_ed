import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eq_ed/components/game_navigation_components/scorer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ScoreDetailsScreen extends StatefulWidget {
  static var id = 'score_details_screen';

  @override
  _ScoreDetailsScreenState createState() => _ScoreDetailsScreenState();
}

class _ScoreDetailsScreenState extends State<ScoreDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    late User loggedInUser;
    int score = 0;
    int empathyScore = 0;
    int communicationScore = 0;
    String level = 'ice queen';

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
                empathyScore = value['empathy_score'].toInt();
                communicationScore = value['communication_score'].toInt();
                score = empathyScore + communicationScore;
                level = Scorer.getLevel(
                    score); // TODO: outsource this logic to server
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
                        "Total score: $score",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 22.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Of which empathy: $empathyScore",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Of which communication: $communicationScore",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 20.0,
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
