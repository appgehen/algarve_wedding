import 'package:flutter/material.dart';
import 'package:algarve_wedding/pages/quiz/quiz_logic.dart';

Widget returnCheatDialogue(BuildContext context) {
  //TODO Text
  return AlertDialog(
    title: Text(
      "Mogeln kann jeder 😉",
      style: TextStyle(
        fontFamily: 'Amatic Regular',
        height: 1.5,
        fontSize: 35,
        color: Colors.white,
      ),
    ),
    content: Text(
      "Dein Versuch wurde gewertet.",
      style: TextStyle(
        fontSize: 15.0,
        height: 1.5,
        color: Colors.white,
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Text('Schließen'),
        onPressed: () {
          resetQuiz();
          int count = 0;
          Navigator.of(context, rootNavigator: true)
              .popUntil((_) => count++ >= 1);
        },
      ),
    ],
  );
}
