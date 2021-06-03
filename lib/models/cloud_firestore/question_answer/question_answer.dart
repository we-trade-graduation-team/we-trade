import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `PostQuestion` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'question_answer.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents answer in a Post Details 's Question.
class QuestionAnswer {
  QuestionAnswer({
    required this.respondentUsername,
    required this.answer,
    required this.createAt,
  });

  /// A necessary factory constructor for creating a new QuestionAnswer instance
  /// from a map. Pass the map to the generated `_$QuestionAnswerFromJson()` constructor.
  /// The constructor is named after the source class, in this case, QuestionAnswer.
  factory QuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerFromJson(json);

  factory QuestionAnswer.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$QuestionAnswerFromJson(snapshot.data() as Map<String, dynamic>);

  @JsonKey(required: true)
  final String respondentUsername;

  @JsonKey(required: true)
  final String answer;

  @JsonKey(required: true)
  final DateTime createAt;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$QuestionAnswerToJson`.
  Map<String, dynamic> toJson() => _$QuestionAnswerToJson(this);
}
