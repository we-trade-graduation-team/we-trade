// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'junction_keyword_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JunctionKeywordPost _$JunctionKeywordPostFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['keywordId', 'postId']);
  return JunctionKeywordPost(
    keywordId: json['keywordId'] as String,
    postId: json['postId'] as String,
  );
}

Map<String, dynamic> _$JunctionKeywordPostToJson(
        JunctionKeywordPost instance) =>
    <String, dynamic>{
      'keywordId': instance.keywordId,
      'postId': instance.postId,
    };
