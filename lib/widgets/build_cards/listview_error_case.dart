import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    /*Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Ups!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Text(
                  'Leider ist da etwas schief gelaufen. Bitte starte die App neu und versuche es noch einmal.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Lottie.asset('assets/dino_light.json'),
        ],
      ),
    );*/
  }
}
