// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_keyword_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserKeywordHistory _$UserKeywordHistoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['keywordId', 'times']);
  return UserKeywordHistory(
    keywordId: json['keywordId'] as String,
    times: json['times'] as int,
  );
}

Map<String, dynamic> _$UserKeywordHistoryToJson(UserKeywordHistory instance) =>
    <String, dynamic>{
      'keywordId': instance.keywordId,
      'times': instance.times,
    };
