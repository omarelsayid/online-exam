import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static late SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    _pref.setString(key, value);
  }

  getString(String key) {
    return _pref.getString(key);
  }
}
