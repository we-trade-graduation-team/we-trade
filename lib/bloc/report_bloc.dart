import 'package:flutter/material.dart';

class ReportBloc extends ChangeNotifier {
  bool _unlockTextField = false;
  bool _confirmed = false;

  bool get unlockTextField => _unlockTextField;
  bool get confirmed => _confirmed;

  set unlockTextField(bool val) {
    _unlockTextField = val;
    notifyListeners();
  }

  set confirmed(bool val) {
    _confirmed = val;
    notifyListeners();
  }

  void changeStateTextField() {
    _unlockTextField = !_unlockTextField;
    notifyListeners();
  }

  void changeStateConfirmed() {
    _confirmed = !_confirmed;
    notifyListeners();
  }
}
