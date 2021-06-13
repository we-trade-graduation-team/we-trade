// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_question_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsQuestionAnswer _$PostDetailsQuestionAnswerFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['respondentUsername', 'answer', 'createAt']);
  return PostDetailsQuestionAnswer(
    respondentUsername: json['respondentUsername'] as String,
    answer: json['answer'] as String,
    createAt: DateTime.parse(json['createAt'] as String),
  );
}

Map<String, dynamic> _$PostDetailsQuestionAnswerToJson(
        PostDetailsQuestionAnswer instance) =>
    <String, dynamic>{
      'respondentUsername': instance.respondentUsername,
      'answer': instance.answer,
      'createAt': instance.createAt.toIso8601String(),
    };
