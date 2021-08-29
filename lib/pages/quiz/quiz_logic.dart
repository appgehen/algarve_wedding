import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/question_countdown.dart';
import 'quiz_loadquestions.dart';
import 'package:firebase_database/firebase_database.dart';

int quizQuestionNumber = 0;
int correctAnswers = 0;
int incorrectAnswers = 0;
bool lastQuestionCorrect;
String playerName;
int timeKeeper = 0;
bool quizEnd = false;
Color color = Colors.transparent;
var currentTime;
List answers = [];
List months = [
  'Januar',
  'Februar',
  'März',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Dezember'
];

var resultListRef = FirebaseDatabase().reference().child('quizResultList');

void checkAnswer(int userPickedAnswer) {
  int _correctAnswer =
      int.parse(quizQuestions[quizQuestionNumber]['correctAnswer']);
  if (quizQuestionNumber < quizQuestions.length - 1 && quizEnd == false) {
    quizQuestionNumber = quizQuestionNumber + 1;
    if (userPickedAnswer == _correctAnswer) {
      answers.add(true);
      correctAnswers = correctAnswers + 1;
      lastQuestionCorrect = true;
    } else {
      answers.add(false);
      incorrectAnswers = incorrectAnswers + 1;
      lastQuestionCorrect = false;
    }
  } else if (quizQuestionNumber == quizQuestions.length - 1 &&
      quizEnd == false) {
    if (userPickedAnswer == _correctAnswer) {
      answers.add(true);
      correctAnswers = correctAnswers + 1;
      lastQuestionCorrect = true;
      quizEnd = true;
      stopTimer();
      saveResultInDatabase();
    } else {
      answers.add(false);
      incorrectAnswers = incorrectAnswers + 1;
      lastQuestionCorrect = false;
      quizEnd = true;
      stopTimer();
      saveResultInDatabase();
    }
  } else {
    quizEnd = true;
    stopTimer();
    saveResultInDatabase();
  }
}

void saveResultInDatabase() {
  if (quizQuestions.length - 1 != quizQuestionNumber) {
    for (var i = quizQuestionNumber; i < quizQuestions.length; i++) {
      answers.add(false);
    }
  }
  resultListRef.push().set({
    'playerName': playerName,
    'correctAnswers': correctAnswers.toString(),
    'incorrectAnswers': incorrectAnswers.toString(),
    'answers': answers,
    'timeKeeper': timeKeeper.toString(),
    'gameTime': currentTime.day.toString() +
        '. ' +
        months[currentTime.month - 1].toString() +
        ' ' +
        currentTime.year.toString(),
  });
}

void resetQuiz() {
  quizQuestionNumber = 0;
  quizEnd = false;
  correctAnswers = 0;
  incorrectAnswers = 0;
  playerName = '';
  timeKeeper = 0;
  answers.clear();
}

void stopTimer() {
  timer.cancel();
}
