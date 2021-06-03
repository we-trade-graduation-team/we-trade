import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper(this._sharedPreference);

  final Future<SharedPreferences> _sharedPreference;

  // final _sharedPreference = SharedPreferences.getInstance();

  static const String darkMode = 'darkMode';
  static const String languageCode = 'languageCode';

  //Theme module
  Future<bool> changeTheme({
    required bool value,
  }) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(darkMode, value);
    });
  }

  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(darkMode) ?? false;
    });
  }

  //Locale module
  Future<bool> changeLanguage(String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(languageCode, value);
    });
  }

  Future<String?> get appLocale {
    return _sharedPreference.then((prefs) {
      return prefs.getString(languageCode);
    });
  }
}
