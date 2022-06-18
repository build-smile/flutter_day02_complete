import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future<bool> setString({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    return data;
  }
}
