import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_details_question.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents question in a Post Question.
class PostDetailsQuestion {
  PostDetailsQuestion({
    required this.question,
    required this.askerId,
    required this.createdAt,
    // this.votes = 0,
    this.questionId,
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

  @JsonKey(required: true)
  final String askerId;

  // @JsonKey(required: true, defaultValue: 0)
  // int votes;

  @JsonKey(required: true)
  final int createdAt;

  Map<String, dynamic> toJson() => _$PostDetailsQuestionToJson(this);
}
