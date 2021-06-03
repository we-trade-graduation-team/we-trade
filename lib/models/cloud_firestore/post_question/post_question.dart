import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../question_answer/question_answer.dart';

/// This allows the `PostQuestion` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'post_question.g.dart';

/// Represents question in a Post Details.

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class PostQuestion {
  PostQuestion({
    required this.questionId,
    required this.question,
    required this.answers,
    this.votes = 0,
  });

  /// A necessary factory constructor for creating a new PostQuestion instance
  /// from a map. Pass the map to the generated `_$PostQuestionFromJson()` constructor.
  /// The constructor is named after the source class, in this case, PostQuestion.
  factory PostQuestion.fromJson(Map<String, dynamic> json) =>
      _$PostQuestionFromJson(json);

  factory PostQuestion.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostQuestionFromJson(snapshot.data() as Map<String, dynamic>);

  @JsonKey(required: true)
  final String questionId;

  @JsonKey(required: true)
  final String question;

  /// Tell json_serializable to use "defaultValue" if the JSON doesn't
  /// contain this key or if the value is `null`.
  @JsonKey(defaultValue: 0)
  final int votes;

  @JsonKey(required: true)
  final List<QuestionAnswer> answers;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PostQuestionToJson`.
  Map<String, dynamic> toJson() => _$PostQuestionToJson(this);
}
