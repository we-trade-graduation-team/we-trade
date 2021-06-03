// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAnswer _$QuestionAnswerFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['respondentUsername', 'answer', 'createAt']);
  return QuestionAnswer(
    respondentUsername: json['respondentUsername'] as String,
    answer: json['answer'] as String,
    createAt: DateTime.parse(json['createAt'] as String),
  );
}

Map<String, dynamic> _$QuestionAnswerToJson(QuestionAnswer instance) =>
    <String, dynamic>{
      'respondentUsername': instance.respondentUsername,
      'answer': instance.answer,
      'createAt': instance.createAt.toIso8601String(),
    };
