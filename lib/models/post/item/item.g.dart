// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['conditions', 'description', 'address']);
  return Item(
    keyword:
        (json['keyword'] as List<dynamic>?)?.map((e) => e as String).toList(),
    conditions: json['conditions'] as String,
    description: json['description'] as String,
    address: Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'keyword': instance.keyword,
      'conditions': instance.conditions,
      'description': instance.description,
      'address': instance.address.toJson(),
    };
