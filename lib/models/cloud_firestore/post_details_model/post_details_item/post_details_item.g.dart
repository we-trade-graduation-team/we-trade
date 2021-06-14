// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsItem _$PostDetailsItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'images',
    'description',
    'condition',
    'address',
    'price',
    'tradeForList'
  ]);
  return PostDetailsItem(
    images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    description: json['description'] as String,
    condition: json['condition'] as String,
    address: PostDetailsItemAddress.fromJson(
        json['address'] as Map<String, dynamic>),
    price: (json['price'] as num).toDouble(),
    tradeForList: (json['tradeForList'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$PostDetailsItemToJson(PostDetailsItem instance) =>
    <String, dynamic>{
      'images': instance.images,
      'description': instance.description,
      'condition': instance.condition,
      'address': instance.address.toJson(),
      'price': instance.price,
      'tradeForList': instance.tradeForList,
    };
