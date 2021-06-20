import 'package:flutter/material.dart';

class LoadingOverlayProvider extends ChangeNotifier {
  LoadingOverlayProvider();

  final _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  void updateLoading({
    required bool isLoading,
  }) {
    notifyListeners();
  }
}
