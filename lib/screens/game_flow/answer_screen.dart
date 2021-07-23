import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/models/server_api.dart';
import 'package:eq_ed/screens/game_flow/feedback_screen.dart';
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
  var answerText = ["", "", ""];
  Map<Answer, int> answerMapping = {
    Answer.one: 0,
    Answer.two: 1,
    Answer.three: 2,
  };

  @override
  void initState() {
    controller = AnimationController(
      value: 2 / 3,
      vsync: this,
    );
    super.initState();
    makeApiCall();
  }

  void makeApiCall() async {
    // todo - replace with currentQuestionId
    print('in api call ' + widget.currentQuestionId);
    String url = 'http://127.0.0.1:5000/getQuestionResponse';
    Map body = {
      "uid": "User1",
      "question_id": widget.currentQuestionId,
    };
    result = await apiRequestGetQuestion(url, body);
    print(result);
    setState(() {
      questionText = result['questionText'];
      answers = (result['answers']).entries.toList();
      numberOfAnswers = (result['numberOfAnswers']).toInt();
      int j = 0;
      for (int i = 0; i < answers.length; i++) {
        // todo - take care of the questions where we only have 2 pos >> maybe fix in tree?
        if (answers[i].value.length > 1) {
          answerText[j] = answers[i].value[1];
          j++;
        }
        answerText[j] = answers[i].value[0];
        j++;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String getNextAnswerId() {
    var index = answerMapping[selectedAnswer];
    return answers[index].key;
  }

  @override
  Widget build(BuildContext context) {
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
                      child: SingleChildScrollView(
                        child: Text(questionText),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(answerText[0]),
                        ),
                        onPress: () {
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
                      height: 10.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(answerText[1]),
                        ),
                        onPress: () {
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
                      height: 10.0,
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(answerText[2]),
                        ),
                        onPress: () {
                          setState(() {
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
                      'Save my answer.',
                      style: kLabelTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPress: () {
                    if (selectedAnswer != Answer.none) {
                      // get the answer id
                      var answerId = getNextAnswerId();

                      // X stands for questionId
                      if (answerId[0] == 'X') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnswerScreen(
                              currentQuestionId: answerId,
                            ),
                          ),
                        );
                        // Z stands for levelEndId
                      } else if (answerId[0] == 'Z') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbackScreen(
                                // currentQuestionId: answerId,
                                ),
                          ),
                        );
                      }
                    } else {
                      // TODO: adjust this per iOS or android OS
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
