import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/game_flow/played_scenarios_screen.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  static var id = 'feedback_screen';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Feedback'),
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
                    'Thanks for playing!',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'Please see your feedback below.',
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
                        cardChild: Text('[Total score: XX/YY]'),
                        onPress: () {
                          return;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: Text('[Communication: XX]'),
                        onPress: () {
                          return;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: Text('[Empathy: XX]'),
                        onPress: () {
                          return;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild:
                            Text('[Placeholder - more detailed feedback]'),
                        onPress: () {
                          return;
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ReusableCard(
                  colour: kPrimaryColor,
                  cardChild: Center(
                    child: Text(
                      'See example answers.',
                      style: kLabelTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPress: () {
                    Navigator.pushNamed(context, PlayedScenariosScreen.id);
                  },
                ),
                ReusableCard(
                  colour: kSecondaryColor,
                  cardChild: Center(
                    child: Text(
                      'Back to home!',
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
