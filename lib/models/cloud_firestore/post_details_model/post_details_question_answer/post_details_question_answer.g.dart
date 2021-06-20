// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_question_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsQuestionAnswer _$PostDetailsQuestionAnswerFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['respondentName', 'answer', 'createdAt']);
  return PostDetailsQuestionAnswer(
    respondentName: json['respondentName'] as String,
    answer: json['answer'] as String,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$PostDetailsQuestionAnswerToJson(
        PostDetailsQuestionAnswer instance) =>
    <String, dynamic>{
      'respondentName': instance.respondentName,
      'answer': instance.answer,
      'createdAt': instance.createdAt,
    };
