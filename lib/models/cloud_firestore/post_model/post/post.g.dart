// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'name',
    'owner',
    'categoryInfo',
    'itemInfo',
    'imagesUrl',
    'tradeForList',
    'isHidden',
    'price'
  ]);
  return Post(
    name: json['name'] as String,
    owner: json['owner'] as String,
    categoryInfo:
        PostCategory.fromJson(json['categoryInfo'] as Map<String, dynamic>),
    itemInfo: PostItem.fromJson(json['itemInfo'] as Map<String, dynamic>),
    imagesUrl:
        (json['imagesUrl'] as List<dynamic>).map((e) => e as String).toList(),
    tradeForList: (json['tradeForList'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    price: json['price'] as int,
    createAt: Post._rawDateTime(json['createAt'] as Timestamp),
    isHidden: json['isHidden'] as bool? ?? false,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'name': instance.name,
      'owner': instance.owner,
      'createAt': instance.createAt.toIso8601String(),
      'categoryInfo': instance.categoryInfo.toJson(),
      'itemInfo': instance.itemInfo.toJson(),
