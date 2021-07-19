import 'dart:convert';
import 'package:eq_ed/components/design_components/animated_image.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/models/server_api.dart';
import 'package:eq_ed/screens/game_flow/answer_screen.dart';
import 'package:flutter/material.dart';

class ScenarioScreen extends StatefulWidget {
  static var id = 'scenario_screen';

  @override
  _ScenarioScreenState createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Map result;
  String levelNarrative = "";
  late String nextQuestionId;

  // todo - get current user function

  @override
  void initState() {
    controller = AnimationController(
      value: 1 / 3,
      vsync: this,
    );
    super.initState();
    makeApiCall();
  }

  void makeApiCall() async {
    String url = 'http://127.0.0.1:5000/initLevelForUser';
    Map body = {
      "uid": "User1",
      "level_id": "X1000",
    };
    result = await apiRequestInitLevel(url, body);
    print(result);
    setState(() {
      levelNarrative = result['levelNarrative'];
      nextQuestionId = result['nextQuestionId'];
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    height: 50.0,
                  ),
                  Text(
                    'Ready, set, go! \nHere is your scenario!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                  ),
                  // try the rest here
                  SingleChildScrollView(
                    child: Text(
                      levelNarrative,
                      style: kLabelTextStyle.copyWith(
                          backgroundColor: kAppBarColor, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                  ),
                  ReusableCard(
                    colour: kSecondaryColor,
                    onPress: () {
                      Navigator.pushNamed(context, AnswerScreen.id);
                    },
                    cardChild: Center(
                      child: Text(
                        'Record response!',
                        style: kLabelTextStyle.copyWith(
                          color: Colors.white,
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
