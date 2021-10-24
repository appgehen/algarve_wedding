import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class ShowCountdownTimer extends StatefulWidget {
  @override
  _ShowCountdownTimerState createState() => _ShowCountdownTimerState();
}

class _ShowCountdownTimerState extends State<ShowCountdownTimer> {
  CountdownTimerController controller;
  int endTime =
      DateTime.parse("2021-10-14 00:00:00").millisecondsSinceEpoch + 1000 * 30;
  int endTimeTimestamp = 1634162400000;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        controller.endTime = endTime;
      });
    });
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //TODO Error if one day prior to end
        CountdownTimer(
          controller: controller,
          widgetBuilder: (_, CurrentRemainingTime time) {
            if (DateTime.now().millisecondsSinceEpoch > endTimeTimestamp) {
              return Text(
                'Wir haben JA gesagt!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              );
            } else if (time.days >= 2) {
              return Text(
                'In ${(time.days + 1).toString()} Tagen ist es soweit!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              );
            } else if (time.days < 2 && time.hours < 2) {
              return Text(
                'Morgen ist es endlich soweit!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              );
            } else if (time.days < 2 && time.hours >= 2) {
              return Text(
                'In ${(time.days + 1).toString()} Tagen ist es soweit!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              );
            } else {
              return Text(
                'Endlich ist es soweit!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              );
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
