import 'package:flutter/material.dart';

Widget buttonFinishQuiz(BuildContext context) {
  return Center(
    child: Padding(
      padding:
          const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 20),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        height: 50,
        minWidth: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text('Quiz beenden'),
        onPressed: () {
          int count = 0;
          Navigator.popUntil(context, (route) {
            return count++ == 1;
          });
        },
      ),
    ),
  );
}
