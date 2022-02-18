import 'package:shared_preferences/shared_preferences.dart';

class Sharepref {
  static SharedPreferences? _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future sets(String keys, String values) async =>
      await _prefs!.setString(keys, values);
  static String? gets(key) => _prefs!.getString(key);
}
