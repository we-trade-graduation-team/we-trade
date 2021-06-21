import 'package:flutter/material.dart';

class LoadingOverlayProvider extends ChangeNotifier {
  LoadingOverlayProvider();

  var _isLoading = false;

  bool get isLoading => _isLoading;

  void updateLoading({
    required bool isLoading,
  }) {
    _isLoading = isLoading;

    notifyListeners();
  }
}
