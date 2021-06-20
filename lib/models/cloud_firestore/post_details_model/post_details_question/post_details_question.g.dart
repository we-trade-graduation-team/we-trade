// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsQuestion _$PostDetailsQuestionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['question', 'votes']);
  return PostDetailsQuestion(
    question: json['question'] as String,
    votes: json['votes'] as int? ?? 0,
  );
}

Map<String, dynamic> _$PostDetailsQuestionToJson(
        PostDetailsQuestion instance) =>
    <String, dynamic>{
      'question': instance.question,
      'votes': instance.votes,
    };
