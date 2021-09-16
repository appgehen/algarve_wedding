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
import 'package:package_info_plus/package_info_plus.dart';

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

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    getThemeMode(context);
    _signIn();
    loadBottomNavItems();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
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
    await _initPackageInfo();
    await bottomNavigationBuild(
        _packageInfo.buildNumber.toString(), _packageInfo.version.toString());
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
