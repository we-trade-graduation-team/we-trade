// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'special_category_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialCategoryCard _$SpecialCategoryCardFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['category', 'photoUrl', 'view']);
  return SpecialCategoryCard(
    category: json['category'] as String,
    photoUrl: json['photoUrl'] as String,
    view: json['view'] as int? ?? 0,
  );
}

Map<String, dynamic> _$SpecialCategoryCardToJson(
        SpecialCategoryCard instance) =>
    <String, dynamic>{
      'category': instance.category,
      'photoUrl': instance.photoUrl,
      'view': instance.view,
    };
