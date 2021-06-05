// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_recommended_post_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecommendedPostCard _$UserRecommendedPostCardFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'imageUrl',
    'title',
    'condition',
    'price',
    'district'
  ]);
  return UserRecommendedPostCard(
    title: json['title'] as String,
    image: json['imageUrl'] as String,
    itemCondition: json['condition'] as String,
    itemPrice: (json['price'] as num).toDouble(),
    district: json['district'] as String,
    view: json['view'] as int?,
  );
}

Map<String, dynamic> _$UserRecommendedPostCardToJson(
        UserRecommendedPostCard instance) =>
    <String, dynamic>{
      'imageUrl': instance.image,
      'title': instance.title,
      'condition': instance.itemCondition,
      'price': instance.itemPrice,
      'district': instance.district,
      'view': instance.view,
    };
