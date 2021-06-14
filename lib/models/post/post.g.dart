// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['name'] as String,
    json['isHidden'] as bool,
    json['owner'] as String,
    json['creatAt'] as String,
    Category.fromJson(json['category'] as Map<String, dynamic>),
    Item.fromJson(json['item'] as Map<String, dynamic>),
    (json['imagesUrl'] as List<dynamic>).map((e) => e as String).toList(),
    (json['tradeForList'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'name': instance.name,
      'owner': instance.owner,
      'creatAt': instance.creatAt,
      'category': instance.category.toJson(),
      'item': instance.item.toJson(),
      'imagesUrl': instance.imagesUrl,
      'tradeForList': instance.tradeForList,
      'isHidden': instance.isHidden,
    };
