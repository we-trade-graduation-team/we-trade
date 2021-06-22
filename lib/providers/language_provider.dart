import 'package:flutter/material.dart';
import '../cache/shared_preference/shared_preference_helper.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider(this._sharedPrefsHelper);

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  var _appLocale = const Locale('vi');

  Locale get appLocale {
    _sharedPrefsHelper.appLocale.then((localeValue) {
      if (localeValue != null) {
        _appLocale = Locale(localeValue);
      }
    });

    return _appLocale;
  }

  void updateLanguage(String languageCode) {
    _appLocale = languageCode == 'vi' ? const Locale('vi') : const Locale('en');

    _sharedPrefsHelper.changeLanguage(languageCode);

    notifyListeners();
  }
}
