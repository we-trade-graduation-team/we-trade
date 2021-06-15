// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_category_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCategoryHistory _$UserCategoryHistoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['categoryId', 'times']);
  return UserCategoryHistory(
    categoryId: json['categoryId'] as String,
    times: json['times'] as int,
  );
}

Map<String, dynamic> _$UserCategoryHistoryToJson(
        UserCategoryHistory instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'times': instance.times,
    };
