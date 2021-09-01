import 'dart:convert';
import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/models/server_api.dart';
import 'package:eq_ed/screens/game_flow/video_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScenarioScreen extends StatefulWidget {
  static var id = 'scenario_screen';
  final String levelId;
  final String questionId;

  const ScenarioScreen(
      {Key? key, required this.levelId, required this.questionId})
      : super(key: key);

  @override
  _ScenarioScreenState createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Map result;
  String levelNarrative = "";
  late String nextQuestionId;
  final _auth = FirebaseAuth.instance;
  String uid = "User1";

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        uid = user.uid;
      }
    } catch (e) {
      print(e);
    }
    String url = kInitLevel;
    Map body = {
      "uid": uid,
      "level_id": widget.levelId,
    };
    print(uid);
    print(widget.levelId);
    result = await apiRequestInitLevel(url, body);
    print(result);
    setState(() {
      levelNarrative = result['levelNarrative'];
      nextQuestionId = result['nextQuestionId'];
    });
  }

  @override
  void initState() {
    controller = AnimationController(
      value: 1 / 3,
      vsync: this,
    );
    super.initState();
    getCurrentUser();
    makeApiCall();
  }

  void makeApiCall() async {
    return;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Scenario'),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15.0,
                      left: 15.0,
                    ),
                    child: LinearProgressIndicator(
                      value: controller.value,
                      semanticsLabel: 'Linear progress indicator',
                      color: kSecondaryColor,
                      backgroundColor: kActiveCardColour,
                    ),
                    // Container(
                    //   child: AnimatedImage(),
                    //   height: 50.0,
                    // ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Ready, set, go! \nHere is your scenario!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  // try the rest here
                  Expanded(
                    child: ReusableCard(
                      cardChild: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            levelNarrative,
                            style: kLabelTextStyle.copyWith(
                              //backgroundColor: kAppBarColor,
                              color: kAppBarColor,
                              fontSize: 19.0,
                            ),
                          ),
                        ),
                      ),
                      onPress: () {},
                    ),
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kSecondaryColor,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              questionId: widget.questionId,
                            ),
                          ),
                        );
                      },
                      cardChild: Center(
                        child: Text(
                          'Show me the first question!',
                          style: kLabelTextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
