import 'package:shared_preferences/shared_preferences.dart';

clearSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
