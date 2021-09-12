import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'logic/account/account_check-state.dart';
import 'package:algarve_wedding/logic/theme-mode/toggle_theme.dart';
import 'package:algarve_wedding/logic/account/account_sign-in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:algarve_wedding/main_loggedin.dart';
import 'logic/theme-mode/light_theme.dart';
import 'logic/theme-mode/dark_theme.dart';
import 'logic/theme-mode/get_theme.dart';
import 'logic/bottom-navigation/bottom-navigation_build.dart';
import 'logic/bottom-navigation/bottom-navigation_load_items.dart';

bool isLoading = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    _signIn();
    loadBottomNavItems();
    super.initState();
  }

  void _signIn() async {
    await loadBottomNavItems();
    await signInAnonymously(context);
    await _bottomNav();
    setState(() {
      isLoading = false;
    });
  }

  void _bottomNav() async {
    await bottomNavigationBuild();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      themeMode: toggleThemeMode('system', context),
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : MyBottomNav(),
      ),
    );
  }
}
