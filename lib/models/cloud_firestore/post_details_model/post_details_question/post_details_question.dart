import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../post_details_question_answer/post_details_question_answer.dart';

part 'post_details_question.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents question in a Post Question.
class PostDetailsQuestion {
  PostDetailsQuestion({
    required this.question,
    this.votes = 0,
    this.questionId,
    this.answers,
  });

  factory PostDetailsQuestion.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsQuestionFromJson(json);

  factory PostDetailsQuestion.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostDetailsQuestionFromJson(snapshot.data() as Map<String, dynamic>)
        ..questionId = snapshot.id;

  @JsonKey(ignore: true)
  String? questionId;

  @JsonKey(required: true)
  final String question;

  @JsonKey(required: true, defaultValue: 0)
  int votes;

  @JsonKey(ignore: true)
  final List<PostDetailsQuestionAnswer>? answers;

  Map<String, dynamic> toJson() => _$PostDetailsQuestionToJson(this);
}
