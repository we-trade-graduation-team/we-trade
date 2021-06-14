// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'name',
    'ownerId',
    'creatAt',
    'category',
    'item',
    'imagesUrl',
    'tradeForListId',
    'isHidden'
  ]);
  return Post(
    name: json['name'] as String,
    isHidden: json['isHidden'] as bool,
    ownerId: json['ownerId'] as String,
    creatAt: json['creatAt'] as String?,
    category: Category.fromJson(json['category'] as Map<String, dynamic>),
    item: Item.fromJson(json['item'] as Map<String, dynamic>),
    imagesUrl:
        (json['imagesUrl'] as List<dynamic>).map((e) => e as String).toList(),
    tradeForListId: (json['tradeForListId'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'name': instance.name,
      'ownerId': instance.ownerId,
      'creatAt': instance.creatAt,
      'category': instance.category.toJson(),
      'item': instance.item.toJson(),
      'imagesUrl': instance.imagesUrl,
      'tradeForListId': instance.tradeForListId,
      'isHidden': instance.isHidden,
    };
