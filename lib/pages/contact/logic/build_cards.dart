import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/cards.dart';
import 'package:algarve_wedding/widgets/build_intro-text/intro-text_streambuilder.dart';

Widget returnDisplayedCard(BuildContext context) {
  if (FirebaseAuth.instance.currentUser != null) {
    print('UID ' + FirebaseAuth.instance.currentUser.uid);
    return Column(
      children: [
        returnCards(launchPhone, '+49 176 30105793', Icons.phone, context),
        returnCards(launchMail, 'smithdaniel@web.de', Icons.mail, context),
        returnCards(
            launchMaps, 'Lichtstraße 29, Düsseldorf', Icons.room, context),
        returnCards(launchDataprotection, 'Datenschutz', Icons.lock, context),
      ],
    );
  } else {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: returnIntroStreamBuilder(
                introSignin, 'intro-signin', 'contact-signin', context),
          ),
        ),
        returnCards(launchMail, 'smithdaniel@web.de', Icons.mail, context),
        returnCards(launchDataprotection, 'Datenschutz', Icons.lock, context),
      ],
    );
  }
}
