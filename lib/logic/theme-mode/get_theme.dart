import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/shared-prefs/save_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller.dart';

//TODO Get the data from the central "read_prefs.dart" function
void getThemeMode(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final key = prefs.getString('brightnessMode');
  Brightness brightness = MediaQuery.platformBrightnessOf(context);
  if (key.toString() == 'Brightness.dark') {
    lightModeActive = false;
    isLightTheme.add(false);
  } else if (key.toString() == 'Brightness.light') {
    lightModeActive = true;
    isLightTheme.add(true);
  } else {
    saveSharedPrefs('brightnessMode', brightness.toString());
    if (brightness.toString() == 'Brightness.dark') {
      lightModeActive = false;
      isLightTheme.add(false);
    } else if (brightness.toString() == 'Brightness.light') {
      lightModeActive = true;
      isLightTheme.add(true);
    }
  }
}
