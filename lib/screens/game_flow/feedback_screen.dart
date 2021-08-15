import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/models/server_api.dart';
import 'package:eq_ed/screens/home_flow/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  static var id = 'feedback_screen';
  final String currentQuestionId;

  const FeedbackScreen({Key? key, required this.currentQuestionId})
      : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  final _auth = FirebaseAuth.instance;
  String uid = "User1";
  late Map result;
  String questionText = "";
  // late ConfettiController confettiController;

  @override
  void initState() {
    controller = AnimationController(
      value: 3 / 3,
      vsync: this,
    );
    super.initState();
    getCurrentUser();
    makeApiCall();
    //confettiController = ConfettiController(duration: Duration(seconds: 5));
    //confettiController.play();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        uid = user.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  void makeApiCall() async {
    print('in api call ' + widget.currentQuestionId);
    String url = kLevelEnd;
    Map body = {
      "uid": uid,
      "question_id": widget.currentQuestionId,
    };
    result = await apiRequestLevelEnd(url, body);
    setState(() {
      questionText = result['questionText'];
      // todo - check if user has completed level --> implement in BE (check this)
    });
  }

  @override
  void dispose() {
    controller.dispose();
    //confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Feedback'),
      ),
      body: Stack(
        children: [
          Column(
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
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        'Thanks for playing!',
                        style: kNormalTextStyle.copyWith(
                          fontSize: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
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
                          child: Text('[Total score: XX/YY]'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: Text('[Communication: XX]'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: Text('[Empathy: XX]'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: Text('Feedback: ' + questionText),
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
          // todo - check if this is on the bottom
          //   Align(
          //     alignment: Alignment.center,
          //     child: ConfettiWidget(
          //       confettiController: confettiController,
          //       colors: [
          //         Colors.red,
          //         Colors.blue,
          //       ],
          //       blastDirectionality: BlastDirectionality.explosive,
          //       shouldLoop: true,
          //       emissionFrequency: 0.05,
          //       numberOfParticles: 5,
          //       gravity: 0.2,
          //       maxBlastForce: 2,
          //       minBlastForce: 1,
          //       particleDrag: 0.1,
          //     ),
          //   ),
        ],
      ),
    );
  }
}
