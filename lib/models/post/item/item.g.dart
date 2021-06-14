// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    (json['keyword'] as List<dynamic>).map((e) => e as String).toList(),
    json['conditions'] as String,
    json['description'] as String,
    Address.fromJson(json['address'] as Map<String, dynamic>),
    (json['price'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'keyword': instance.keyword,
      'conditions': instance.conditions,
      'description': instance.description,
      'address': instance.address.toJson(),
      'price': instance.price,
    };
