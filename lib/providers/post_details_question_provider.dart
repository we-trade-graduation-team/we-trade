import 'package:flutter/material.dart';

class PostDetailsQuestionProvider extends ChangeNotifier {
  PostDetailsQuestionProvider({
    this.questionId,
  });

  String? questionId;

  String? get getPostQuestionId => questionId;

  void updatePostDetailsQuestionId({
    required String? questionID,
  }) {
    questionId = questionID;

    notifyListeners();
  }
}
