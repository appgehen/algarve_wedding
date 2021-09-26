import 'package:shared_preferences/shared_preferences.dart';

bool darkMode;

void getThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final key = prefs.getString('brightnessMode');
  if (key == "Brightness.light") {
    darkMode = false;
  } else {
    darkMode = true;
  }
}
