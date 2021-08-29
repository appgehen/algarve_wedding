import 'package:flutter/material.dart';

void alertCurious(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Neugierig?",
            style: TextStyle(
              fontFamily: 'Amatic Regular',
              height: 1.5,
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          content: Text(
            "Damit die ganze Vorfreude noch nicht weg ist, werden wir die Location erst in Kürze bekannt geben. Stay tuned. 😎",
            style: TextStyle(
              fontSize: 15.0,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      });
}
