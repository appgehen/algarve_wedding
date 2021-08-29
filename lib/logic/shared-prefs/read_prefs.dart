import 'package:shared_preferences/shared_preferences.dart';

readSharedPrefs(String _key) async {
  final prefs = await SharedPreferences.getInstance();
  final key = prefs.getString(_key).toString();
  return key;
}
