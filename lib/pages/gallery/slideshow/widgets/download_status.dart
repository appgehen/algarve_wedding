import 'package:flutter/material.dart';

Widget downloadStatus(BuildContext context) {
  return Center(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                'Lade das Bilder herunter...',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            )
          ],
        ),
      ),
    ),
  );
}
