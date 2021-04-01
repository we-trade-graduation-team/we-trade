
import 'package:flutter/cupertino.dart';

class ReportBloc extends ChangeNotifier{
  bool _unlockTextField =false;
  bool _confirmed= false;

  bool get unlockTextField =>_unlockTextField;
  bool get confirmed => _confirmed;

  set UnlockTextField (bool val){
    _unlockTextField=val;
    notifyListeners();
  }
  set Confirmed(bool val){
    _confirmed=val;
    notifyListeners();
  }

  void ChangeStateTextField(){
    _unlockTextField=!_unlockTextField;
    notifyListeners();
  }
  void ChangeStateConfirmed(){
    _confirmed=!_confirmed;
    notifyListeners();
  }
}