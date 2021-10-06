import 'package:flutter/material.dart';
import 'package:algarve_wedding/main_loggedin.dart';
import '../../pages/sign-in/sign-in_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:algarve_wedding/logic/theme-mode/get_theme.dart';
import 'package:algarve_wedding/logic/shared-prefs/read_prefs.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _sharedPrefs;

  @override
  void initState() {
    getThemeMode(context);
    final adminMode = readSharedPrefs('invitationCode');
    print(adminMode);
    if (adminMode.toString().isNotEmpty) {
      _sharedPrefs = true;
    } else {
      _sharedPrefs = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges().asBroadcastStream(),
      builder: (context, snapshot) {
        if (FirebaseAuth.instance.currentUser != null && _sharedPrefs == true) {
          return MyBottomNav();
        } else {
          return SignInToApp();
        }
      },
    );
  }
}
