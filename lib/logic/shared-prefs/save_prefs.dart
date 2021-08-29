import 'package:shared_preferences/shared_preferences.dart';

saveSharedPrefs(String _key, String _inputValue) async {
  final prefs = await SharedPreferences.getInstance();
  final key = _key;

  prefs.setString(key, _inputValue);
  print(key + _inputValue);
}
