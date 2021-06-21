import 'package:flutter/material.dart';

class PostDetailsFollowProvider extends ChangeNotifier {
  PostDetailsFollowProvider({
    required this.isFollowed,
  });

  bool isFollowed;

  bool get isFollower => isFollowed;

  void updatePostDetailsFollow() {
    isFollowed = !isFollowed;

    notifyListeners();
  }
}
