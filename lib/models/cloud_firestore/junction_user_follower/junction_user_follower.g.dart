// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'junction_user_follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JunctionUserFollower _$JunctionUserFollowerFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['uid', 'followerId']);
  return JunctionUserFollower(
    uid: json['uid'] as String,
    followerId: json['followerId'] as String,
  );
}

Map<String, dynamic> _$JunctionUserFollowerToJson(
        JunctionUserFollower instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'followerId': instance.followerId,
    };
