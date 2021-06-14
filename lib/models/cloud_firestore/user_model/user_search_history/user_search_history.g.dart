// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSearchHistory _$UserSearchHistoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['searchTerm', 'times']);
  return UserSearchHistory(
    searchTerm: json['searchTerm'] as String,
    times: json['times'] as int,
  );
}

Map<String, dynamic> _$UserSearchHistoryToJson(UserSearchHistory instance) =>
    <String, dynamic>{
      'searchTerm': instance.searchTerm,
      'times': instance.times,
    };
