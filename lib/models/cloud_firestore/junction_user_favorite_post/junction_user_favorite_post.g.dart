// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'junction_user_favorite_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JunctionUserFavoritePost _$JunctionUserFavoritePostFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['uid', 'postId']);
  return JunctionUserFavoritePost(
    uid: json['uid'] as String,
    postId: json['postId'] as String,
  );
}

Map<String, dynamic> _$JunctionUserFavoritePostToJson(
        JunctionUserFavoritePost instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'postId': instance.postId,
    };
