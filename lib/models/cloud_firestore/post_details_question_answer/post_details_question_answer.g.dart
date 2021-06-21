// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_question_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsQuestionAnswer _$PostDetailsQuestionAnswerFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['respondentId', 'answer', 'createdAt']);
  return PostDetailsQuestionAnswer(
    respondentId: json['respondentId'] as String,
    answer: json['answer'] as String,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$PostDetailsQuestionAnswerToJson(
        PostDetailsQuestionAnswer instance) =>
    <String, dynamic>{
      'respondentId': instance.respondentId,
      'answer': instance.answer,
      'createdAt': instance.createdAt,
    };
