import 'package:eq_ed/components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/register_screen.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  static var id = 'info_screen';

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Info'),
      ),
      body: ReusableCard(
        cardChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'I am here to help you get used to typical university workplace scenarios. '
                  'You will be shown videos and be asked to record a response. '
                  'Then I will give you some tips on how to make your response even better! '
                  'We will focus on your shown soft skills. '
                  'Click below to get started or find out more about how I developed these scenarios.',
                  style: kNormalTextStyle.copyWith(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                  child: Text(
                    'No account? Sign Up!',
                    style: kLabelTextStyle,
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        onPress: () {},
      ),
    );
  }
}
