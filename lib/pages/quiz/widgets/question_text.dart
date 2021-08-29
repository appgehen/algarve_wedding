import 'package:flutter/material.dart';
import 'package:algarve_wedding/pages/quiz/quiz_logic.dart';
import 'package:algarve_wedding/pages/quiz/quiz_loadquestions.dart';

Widget getQuestionText(context) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Center(
      child: Text(
        quizQuestions[quizQuestionNumber]['questionText'],
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline3,
      ),
    ),
  );
}
