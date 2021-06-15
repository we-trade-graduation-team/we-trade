// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['keyword']);
  return Keyword(
    keyword: json['keyword'] as String,
  );
}

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      'keyword': instance.keyword,
    };
