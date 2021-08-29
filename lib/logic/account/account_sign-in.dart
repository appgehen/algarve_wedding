import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/account/account_check-state.dart';

Future<void> signInAnonymously(BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    print(userCredential);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LandingPage(),
        ));
  } catch (e) {
    print(e); // TODO: show dialog with error
  }
}
