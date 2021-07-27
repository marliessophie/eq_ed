import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/models/server_api.dart';
import 'package:eq_ed/screens/game_flow/answer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TryAgainScreen extends StatefulWidget {
  static var id = 'try_again_screen';
  final String currentQuestionId;

  const TryAgainScreen({Key? key, required this.currentQuestionId})
      : super(key: key);

  @override
  _TryAgainScreenState createState() => _TryAgainScreenState();
}

class _TryAgainScreenState extends State<TryAgainScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  final _auth = FirebaseAuth.instance;
  String uid = "User1";
  late Map result;
  String questionText = "";
  late String nextQuestionId;

  @override
  void initState() {
    controller = AnimationController(
      value: 3 / 3,
      vsync: this,
    );
    super.initState();
    getCurrentUser();
    makeApiCall();
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
    String url = 'http://127.0.0.1:5000/getLevelEnd';
    Map body = {
      "uid": uid,
      "question_id": widget.currentQuestionId,
    };
    result = await apiRequestLevelEnd(url, body);
    setState(() {
      questionText = result['questionText'];
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
                    'Think about it...',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Please read the response provided below',
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
                      'Try again!',
                      style: kLabelTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerScreen(
                          currentQuestionId: nextQuestionId,
                        ),
                      ),
                    );
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
