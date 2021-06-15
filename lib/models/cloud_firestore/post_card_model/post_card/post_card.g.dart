// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCard _$PostCardFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['title', 'item', 'view']);
  return PostCard(
    title: json['title'] as String,
    item: PostCardItem.fromJson(json['item'] as Map<String, dynamic>),
    view: json['view'] as int? ?? 0,
  );
}

Map<String, dynamic> _$PostCardToJson(PostCard instance) => <String, dynamic>{
      'title': instance.title,
      'item': instance.item.toJson(),
      'view': instance.view,
    };
