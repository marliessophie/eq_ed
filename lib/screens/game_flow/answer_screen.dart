import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/models/server_api.dart';
import 'package:eq_ed/screens/game_flow/feedback_screen.dart';
import 'package:eq_ed/screens/game_flow/try_again_screen.dart';
import 'package:eq_ed/screens/game_flow/video_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eq_ed/components/design_components/alert.dart';

enum Answer {
  one,
  two,
  three,
  none,
}

class AnswerScreen extends StatefulWidget {
  static var id = 'answer_screen';
  final String currentQuestionId;

  const AnswerScreen({Key? key, required this.currentQuestionId})
      : super(key: key);

  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Answer selectedAnswer = Answer.none;
  late Map result;
  late int numberOfAnswers;
  String questionText = "";
  late var answers;
  late var answerIds;
  var answerText = ["", "", ""];
  Map<Answer, int> answerMapping = {
    Answer.one: 0,
    Answer.two: 1,
    Answer.three: 2,
  };
  final _auth = FirebaseAuth.instance;
  String uid = "User1";

  @override
  void initState() {
    controller = AnimationController(
      value: 2 / 3,
      vsync: this,
    );
    super.initState();
    makeApiCall();
  }

  void scoreUserApiCall(String answerId) async {
    String url = kScoreUser;
    Map body = {
      "uid": uid,
      "answer_id": answerId,
    };
    result = await apiScoreUser(url, body);
  }

  void makeApiCall() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        uid = user.uid;
      }
    } catch (e) {
      print(e);
    }
    print('in api call ' + widget.currentQuestionId);
    String url = kGetQuestionResponse;
    Map body = {
      "uid": uid,
      "question_id": widget.currentQuestionId,
    };
    result = await apiRequestGetQuestion(url, body);
    setState(() {
      questionText = result['questionText'];
      answers = (result['answers']).entries.toList();
      answerIds = (result['answerIds']).entries.toList();
      numberOfAnswers = (result['numberOfAnswers']).toInt();
      int j = 0;
      for (int i = 0; i < answers.length; i++) {
        if (answers[i].value.length > 1) {
          answerText[j] = answers[i].value[1];
          j++;
          // if i == 0 then set answer.one = 0, answer.two = 0, answer.three = 1,
          if (i == 0) {
            answerMapping = {
              Answer.one: 0,
              Answer.two: 0,
              Answer.three: 1,
            };
            // if i == 1 then set answer.one = 0, answer.two = 1, answer.three = 1
          } else if (i == 1) {
            answerMapping = {
              Answer.one: 0,
              Answer.two: 1,
              Answer.three: 1,
            };
          }
          // else leave the mapping as is as we never enter this loop
        }
        answerText[j] = answers[i].value[0];
        j++;
      }
    });
  }

  void showAnswer(int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(Icons.home),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(answerText[index]),
                    flex: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String getNextAnswerId() {
    var index = answerMapping[selectedAnswer];
    print(answers[index].key);
    return answers[index].key;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var heigth = queryData.size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Answer'),
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
                    'How would you respond?',
                    style: kNormalTextStyle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'Tap the Boxes to see different \n possibilities below.',
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
                      child: SingleChildScrollView(
                        child: Text(questionText),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text('Tap for Answer 1'),
                        ),
                        onPress: () {
                          showAnswer(0);
                          setState(() {
                            selectedAnswer = Answer.one;
                          });
                        },
                        colour: selectedAnswer == Answer.one
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        borderColor: kAppBarColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text('Tap for Answer 2'),
                        ),
                        onPress: () {
                          showAnswer(1);
                          setState(() {
                            selectedAnswer = Answer.two;
                          });
                        },
                        colour: selectedAnswer == Answer.two
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        borderColor: kAppBarColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text('Tap for Answer 3'),
                        ),
                        //child: Text(answerText[2]),
                        //child: Text(answerText[2]),
                        onPress: () {
                          setState(() {
                            showAnswer(2);
                            selectedAnswer = Answer.three;
                          });
                        },
                        colour: selectedAnswer == Answer.three
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        borderColor: kAppBarColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
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
                      'Save my answer.',
                      style: kLabelTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPress: () {
                    print(selectedAnswer);
                    if (selectedAnswer != Answer.none) {
                      // get the answer id
                      var scoreAnswerId =
                          answerIds[answerMapping[selectedAnswer]].value;
                      scoreUserApiCall(scoreAnswerId);
                      var answerId = getNextAnswerId();
                      // X stands for questionId
                      if (answerId[0] == 'X') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              questionId: answerId,
                            ),
                          ),
                        );
                        // Z stands for levelEndId
                      } else if (answerId[0] == 'Z') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbackScreen(
                              currentQuestionId: answerId,
                            ),
                          ),
                        );
                      } else if (answerId[0] == 'A') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TryAgainScreen(
                              currentQuestionId: answerId,
                            ),
                          ),
                        );
                      }
                    } else {
                      UserAlert.showMessageOneButton(
                          context,
                          'No Answer selected',
                          'Please select one of the provided answers by clicking on it.',
                          'OK',
                          onPressed);
                    }
                  },
                ),
                ReusableCard(
                  colour: kSecondaryColor,
                  cardChild: Center(
                    child: Text(
                      'Re-watch the scenario.',
                      style: kLabelTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPress: () {
                    Navigator.pop(context);
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
