import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_details_question_answer.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents answer in a Post Details 's Question Answer.
class PostDetailsQuestionAnswer {
  PostDetailsQuestionAnswer({
    required this.respondentId,
    required this.answer,
    required this.createdAt,
  });

  factory PostDetailsQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsQuestionAnswerFromJson(json);

  factory PostDetailsQuestionAnswer.fromDocumentSnapshot(
          DocumentSnapshot snapshot) =>
      _$PostDetailsQuestionAnswerFromJson(
          snapshot.data() as Map<String, dynamic>)
        ..answerId = snapshot.id;

  @JsonKey(ignore: true)
  String? answerId;

  @JsonKey(required: true)
  final String respondentId;

  @JsonKey(required: true)
  final String answer;

  @JsonKey(required: true)
  final int createdAt;

  Map<String, dynamic> toJson() => _$PostDetailsQuestionAnswerToJson(this);
}
