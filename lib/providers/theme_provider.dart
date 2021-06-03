import 'package:flutter/material.dart';
import '../cache/shared_preference/shared_preference_helper.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._sharedPrefsHelper);

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  bool _isDarkModeOn = false;

  bool get isDarkModeOn {
    _sharedPrefsHelper.isDarkMode.then((statusValue) {
      _isDarkModeOn = statusValue;
    });

    return _isDarkModeOn;
  }

  void updateTheme({
    required bool isDarkModeOn,
  }) {
    _sharedPrefsHelper.changeTheme(value: isDarkModeOn);

    _sharedPrefsHelper.isDarkMode.then((darkModeStatus) {
      _isDarkModeOn = darkModeStatus;
    });

    notifyListeners();
  }
}
