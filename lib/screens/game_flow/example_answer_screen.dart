import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/components/game_navigation_components/scenario_mapper.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:flutter/material.dart';

class ExampleAnswerScreen extends StatelessWidget {
  static var id = 'example_answer_screen';
  final ScenarioNumber scenario;
  String scenarioName = '';

  ExampleAnswerScreen({required this.scenario}) {
    scenarioName = ScenarioMapper.scenarios[scenario]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Example Answer'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Example answer for: \n\'$scenarioName\'',
                      style: kNormalTextStyle.copyWith(
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'See BCG\'s recommendation below.',
                      style: kNormalTextStyle.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
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
                        Navigator.pushNamed(context, HomeScreen.id);
                      },
                      cardChild: Center(
                        child: Text(
                          'Back home.',
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
          ),
        ],
      ),
    );
  }
}
