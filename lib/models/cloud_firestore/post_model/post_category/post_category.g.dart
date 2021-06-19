// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCategory _$PostCategoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['mainCategoryId', 'subCategoryId']);
  return PostCategory(
    mainCategoryId: json['mainCategoryId'] as String,
    subCategoryId: json['subCategoryId'] as String,
  );
}

Map<String, dynamic> _$PostCategoryToJson(PostCategory instance) =>
    <String, dynamic>{
      'mainCategoryId': instance.mainCategoryId,
      'subCategoryId': instance.subCategoryId,
    };
