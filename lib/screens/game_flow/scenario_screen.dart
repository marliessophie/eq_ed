import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/game_flow/answer_screen.dart';
import 'package:flutter/material.dart';

class ScenarioScreen extends StatefulWidget {
  static var id = 'scenario_screen';

  @override
  _ScenarioScreenState createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen> {
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
                  Text(
                    'Ready, set, go! \nHere is your scenario!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  // try the rest here
                  Text(
                    '[Video placeholder]',
                    style: kLabelTextStyle.copyWith(
                        backgroundColor: kAppBarColor, color: Colors.white),
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
