// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_card_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCardItem _$PostCardItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['image', 'condition', 'district', 'price']);
  return PostCardItem(
    image: json['image'] as String,
    condition: json['condition'] as String,
    district: json['district'] as String,
    price: (json['price'] as num).toDouble(),
  );
}

Map<String, dynamic> _$PostCardItemToJson(PostCardItem instance) =>
    <String, dynamic>{
      'image': instance.image,
      'condition': instance.condition,
      'district': instance.district,
      'price': instance.price,
    };
