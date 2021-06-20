// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetails _$PostDetailsFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['title', 'itemInfo', 'ownerInfo']);
  return PostDetails(
    title: json['title'] as String,
    itemInfo:
        PostDetailsItem.fromJson(json['itemInfo'] as Map<String, dynamic>),
    ownerInfo:
        PostDetailsOwner.fromJson(json['ownerInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostDetailsToJson(PostDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'itemInfo': instance.itemInfo.toJson(),
      'ownerInfo': instance.ownerInfo.toJson(),
    };
