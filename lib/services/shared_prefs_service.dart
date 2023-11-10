import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static storeLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  static Future<String?> loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  static Future<bool> removeLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('language');
  }
}
