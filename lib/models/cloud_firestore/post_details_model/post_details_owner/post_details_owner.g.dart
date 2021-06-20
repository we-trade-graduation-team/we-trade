// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsOwner _$PostDetailsOwnerFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'uid',
    'legitimacy',
    'avatarURL',
    'name',
    'lastSeen'
  ]);
  return PostDetailsOwner(
    uid: json['uid'] as String,
    legitimacy: (json['legitimacy'] as num).toDouble(),
    avatarURL: json['avatarURL'] as String,
    name: json['name'] as String,
    lastSeen: json['lastSeen'] as int,
  );
}

Map<String, dynamic> _$PostDetailsOwnerToJson(PostDetailsOwner instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'legitimacy': instance.legitimacy,
      'avatarURL': instance.avatarURL,
      'name': instance.name,
      'lastSeen': instance.lastSeen,
    };
