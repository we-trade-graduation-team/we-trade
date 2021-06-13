// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsQuestion _$PostDetailsQuestionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['questionId', 'question', 'answers']);
  return PostDetailsQuestion(
    questionId: json['questionId'] as String,
    question: json['question'] as String,
    answers: (json['answers'] as List<dynamic>)
        .map((e) =>
            PostDetailsQuestionAnswer.fromJson(e as Map<String, dynamic>))
        .toList(),
    votes: json['votes'] as int? ?? 0,
  );
}

Map<String, dynamic> _$PostDetailsQuestionToJson(
        PostDetailsQuestion instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'question': instance.question,
      'votes': instance.votes,
      'answers': instance.answers.map((e) => e.toJson()).toList(),
    };
