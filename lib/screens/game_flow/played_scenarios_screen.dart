import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/components/game_navigation_components/scenario_mapper.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/game_flow/example_answer_screen.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:flutter/material.dart';

// TODO: implement a model to retrieve the played scenarios in this round

class PlayedScenariosScreen extends StatefulWidget {
  static var id = 'played_scenarios_screen';

  @override
  _PlayedScenariosScreenState createState() => _PlayedScenariosScreenState();
}

class _PlayedScenariosScreenState extends State<PlayedScenariosScreen> {
  late ScenarioNumber selectedScenario = ScenarioNumber.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Played Scenarios'),
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
                    'Which example answer \n would you like to see?',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'Please choose your answer below.',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 18.0,
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
                      child: ReusableCard(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('[Placeholder: Scenario 1]'),
                        ),
                        onPress: () {
                          setState(() {
                            selectedScenario = ScenarioNumber.one;
                          });
                        },
                        colour: selectedScenario == ScenarioNumber.one
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        borderColor: kAppBarColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('[Placeholder: Scenario 2]'),
                        ),
                        onPress: () {
                          setState(() {
                            selectedScenario = ScenarioNumber.two;
                          });
                        },
                        colour: selectedScenario == ScenarioNumber.two
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        borderColor: kAppBarColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('[Placeholder: Scenario 3]'),
                        ),
                        onPress: () {
                          setState(() {
                            selectedScenario = ScenarioNumber.three;
                          });
                        },
                        colour: selectedScenario == ScenarioNumber.three
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        borderColor: kAppBarColor,
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ReusableCard(
                  colour: kPrimaryColor,
                  cardChild: Center(
                    child: Text(
                      'Show me the example answer!',
                      style: kLabelTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPress: () {
                    if (selectedScenario != ScenarioNumber.none) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExampleAnswerScreen(
                            scenario: selectedScenario,
                          ),
                        ),
                      );
                    } else {
                      // TODO: adjust this per iOS or android OS
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('No Scenario selected'),
                          content: const Text(
                              'Please select one of the shown scenarios by clicking on the respective name.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                          elevation: 24.0,
                        ),
                      );
                    }
                  },
                ),
                ReusableCard(
                  colour: kSecondaryColor,
                  cardChild: Center(
                    child: Text(
                      'Go back home!',
                      style: kLabelTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPress: () {
                    Navigator.pushNamed(context, HomeScreen.id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
