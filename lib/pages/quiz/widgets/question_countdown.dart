import 'package:flutter/material.dart';
import 'package:algarve_wedding/pages/quiz/quiz_logic.dart';
import 'dart:async';

Timer timer;

class QuestionCountdown extends StatefulWidget {
  @override
  _QuestionCountdownState createState() => _QuestionCountdownState();
}

class _QuestionCountdownState extends State<QuestionCountdown> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          timeKeeper++;
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 40,
        child: Text(
          'Benötigte Zeit: ' + timeKeeper.toString() + ' Sekunden',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
