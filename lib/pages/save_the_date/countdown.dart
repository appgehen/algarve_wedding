import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class ShowCountdownTimer extends StatefulWidget {
  @override
  _ShowCountdownTimerState createState() => _ShowCountdownTimerState();
}

class _ShowCountdownTimerState extends State<ShowCountdownTimer> {
  CountdownTimerController controller;
  int endTime =
      DateTime.parse("2021-10-14 12:00:00").millisecondsSinceEpoch + 1000 * 30;

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
        CountdownTimer(
          controller: controller,
          widgetBuilder: (_, CurrentRemainingTime time) {
            if (time == null) {
              return Text(
                'Endlich ist es soweit!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              );
            } else {
              if (time.days == null && time.hours != null) {
                return Column(
                  children: [
                    Text(
                      'In ${time.hours.toString()} Stunden ist es soweit!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                );
              }
              if (time.days == null && time.hours == null && time.min != null) {
                if (time.min < 2) {
                  return Column(
                    children: [
                      Text(
                        'In einer Minute ist es soweit!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text(
                        'In ${time.min.toString()} Minuten ist es soweit!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  );
                }
              }
              if (endTime <= DateTime.now().millisecondsSinceEpoch) {
                return Container();
              }
              if (time.days == 1) {
                return Text(
                  'Morgen ist es soweit!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                );
              } else {
                return Text(
                  'In ${(time.days + 1).toString()} Tagen ist es soweit!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                );
              }
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
