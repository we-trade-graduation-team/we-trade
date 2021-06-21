// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsQuestion _$PostDetailsQuestionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['question', 'askerId', 'createdAt']);
  return PostDetailsQuestion(
    question: json['question'] as String,
    askerId: json['askerId'] as String,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$PostDetailsQuestionToJson(
        PostDetailsQuestion instance) =>
    <String, dynamic>{
      'question': instance.question,
      'askerId': instance.askerId,
      'createdAt': instance.createdAt,
    };
