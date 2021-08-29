import 'package:flutter/material.dart';
import 'package:algarve_wedding/pages/quiz/quiz_loadquestions.dart';
import 'package:algarve_wedding/pages/quiz/quiz_logic.dart';

class quizButtonOne extends StatelessWidget {
  final ValueChanged<int> showNextQuestion;
  quizButtonOne({this.showNextQuestion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        height: 50,
        minWidth: MediaQuery.of(context).size.width,
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        child: Text(
          quizQuestions[quizQuestionNumber]['answerOptionOne'],
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onPressed: () {
          checkAnswer(1);
          showNextQuestion(quizQuestionNumber);
        },
      ),
    );
  }
}

class quizButtonTwo extends StatelessWidget {
  final ValueChanged<int> showNextQuestion;
  quizButtonTwo({this.showNextQuestion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        height: 50,
        minWidth: MediaQuery.of(context).size.width,
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        child: Text(
          quizQuestions[quizQuestionNumber]['answerOptionTwo'],
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onPressed: () {
          checkAnswer(2);
          showNextQuestion(quizQuestionNumber);
        },
      ),
    );
  }
}

class quizButtonThree extends StatelessWidget {
  final ValueChanged<int> showNextQuestion;
  quizButtonThree({this.showNextQuestion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        height: 50,
        minWidth: MediaQuery.of(context).size.width,
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        child: Text(
          quizQuestions[quizQuestionNumber]['answerOptionThree'],
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onPressed: () {
          checkAnswer(3);
          showNextQuestion(quizQuestionNumber);
        },
      ),
    );
  }
}
