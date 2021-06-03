// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCard _$PostCardFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'imageUrl',
    'title',
    'condition',
    'price',
    'district',
    'view'
  ]);
  return PostCard(
    title: json['title'] as String,
    image: json['imageUrl'] as String,
    itemCondition: json['condition'] as String,
    itemPrice: (json['price'] as num).toDouble(),
    district: json['district'] as String,
    view: json['view'] as int,
  );
}

Map<String, dynamic> _$PostCardToJson(PostCard instance) => <String, dynamic>{
      'imageUrl': instance.image,
      'title': instance.title,
      'condition': instance.itemCondition,
      'price': instance.itemPrice,
      'district': instance.district,
      'view': instance.view,
    };
