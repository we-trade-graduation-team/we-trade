// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostQuestion _$PostQuestionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['questionId', 'question', 'answers']);
  return PostQuestion(
    questionId: json['questionId'] as String,
    question: json['question'] as String,
    answers: (json['answers'] as List<dynamic>)
        .map((e) => QuestionAnswer.fromJson(e as Map<String, dynamic>))
        .toList(),
    votes: json['votes'] as int? ?? 0,
  );
}

Map<String, dynamic> _$PostQuestionToJson(PostQuestion instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'question': instance.question,
      'votes': instance.votes,
      'answers': instance.answers.map((e) => e.toJson()).toList(),
    };
