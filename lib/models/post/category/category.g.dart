// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['mainCategoryId', 'subCategoryId']);
  return Category(
    mainCategoryId: json['mainCategoryId'] as String,
    subCategoryId: json['subCategoryId'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'mainCategoryId': instance.mainCategoryId,
      'subCategoryId': instance.subCategoryId,
    };
