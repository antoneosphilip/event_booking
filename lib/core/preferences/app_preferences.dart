import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyCurrentUserEmail = 'currentUserEmail';
  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_keyIsLoggedIn, value);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> setCurrentUserEmail(String email) async {
    await _prefs.setString(_keyCurrentUserEmail, email);
  }

  String? getCurrentUserEmail() {
    return _prefs.getString(_keyCurrentUserEmail);
  }

  Future<void> clearAuth() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyCurrentUserEmail);
  }
}
