// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostItem _$PostItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['condition', 'description', 'addressInfo']);
  return PostItem(
    condition: json['condition'] as String,
    description: json['description'] as String,
    addressInfo:
        PostItemAddress.fromJson(json['addressInfo'] as Map<String, dynamic>),
    keywords:
        (json['keywords'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PostItemToJson(PostItem instance) => <String, dynamic>{
      'condition': instance.condition,
      'description': instance.description,
      'addressInfo': instance.addressInfo.toJson(),
      'keywords': instance.keywords,
    };
