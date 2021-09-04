import 'package:flutter/material.dart';
import 'quiz_logic.dart';
import 'widgets/button_answer.dart';
import 'widgets/question_image.dart';
import 'widgets/question_text.dart';
import 'widgets/question_countdown.dart';
import 'quiz_finished.dart';

class QuizQuestionsNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Findest Du unsere Unterkunft, " + playerName + "?"),
      ),
      body: Container(
        child: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void _showNextQuestion(int count) {
    if (quizEnd == false) {
      setState(() {
        quizQuestionNumber = count;
        if (lastQuestionCorrect == true) {
          color = Color.fromRGBO(46, 125, 50, 0.6);
        } else {
          color = Color.fromRGBO(198, 40, 40, 0.6);
        }
        resetColor();
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizFinished(),
          )).then(
        (value) => Navigator.pop(context),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    currentTime = new DateTime.now();
  }

  void resetColor() async {
    await new Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      color = Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        getQuestionImage(context),
                        Container(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                        getQuestionText(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  AnimatedContainer(
                    decoration: BoxDecoration(
                      color: color,
                    ),
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        quizButtonOne(showNextQuestion: _showNextQuestion),
                        quizButtonTwo(showNextQuestion: _showNextQuestion),
                        quizButtonThree(showNextQuestion: _showNextQuestion),
                        QuestionCountdown(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
