import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/shared-prefs/save_prefs.dart';
import 'controller.dart';
import 'get_theme.dart';

ThemeMode toggleThemeMode(String displaymode, BuildContext context) {
  if (displaymode == 'Brightness.dark') {
    lightModeActive = false;
    return ThemeMode.dark;
  } else if (displaymode == 'Brightness.light') {
    lightModeActive = true;
    return ThemeMode.light;
  } else if (displaymode == 'Brightness.toggle') {
    if (lightModeActive == true) {
      saveSharedPrefs('brightnessMode', 'Brightness.dark');
      lightModeActive = false;
      isLightTheme.add(false);
    } else {
      saveSharedPrefs('brightnessMode', 'Brightness.light');
      lightModeActive = true;
      isLightTheme.add(true);
    }
  } else if (displaymode == 'system') {
    getThemeMode(context);
  }
}
