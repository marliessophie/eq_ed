import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:flutter/material.dart';

class ExampleAnswerScreen extends StatefulWidget {
  static var id = 'example_answer_screen';

  @override
  _ExampleAnswerScreenState createState() => _ExampleAnswerScreenState();
}

class _ExampleAnswerScreenState extends State<ExampleAnswerScreen> {
  String scenarioName = 'Team Meeting';

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
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Example answer for scenario: \'$scenarioName\'',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'See BCG\'s recommendation below',
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
                      child: Text(
                        '[Video placeholder]',
                        style: kLabelTextStyle.copyWith(
                            backgroundColor: kAppBarColor, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                        child: ReusableCard(
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
                    )),
                  ],
                ),
              ),
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }
}
