import 'package:flutter/material.dart';

class PostDetailsFavoriteProvider extends ChangeNotifier {
  PostDetailsFavoriteProvider({
    required this.isFavorite,
  });

  bool isFavorite;

  bool get isPostDetailsFavorite => isFavorite;

  void updatePostDetailsFavorite() {
    isFavorite = !isFavorite;

    notifyListeners();
  }
}
