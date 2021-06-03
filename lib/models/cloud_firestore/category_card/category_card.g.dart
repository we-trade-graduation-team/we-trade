// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryCard _$CategoryCardFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['category', 'icon', 'priority']);
  return CategoryCard(
    category: json['category'] as String,
    iconKey: json['icon'] as String,
    priority: json['priority'] as int,
  );
}

Map<String, dynamic> _$CategoryCardToJson(CategoryCard instance) =>
    <String, dynamic>{
      'category': instance.category,
      'icon': instance.iconKey,
      'priority': instance.priority,
    };
