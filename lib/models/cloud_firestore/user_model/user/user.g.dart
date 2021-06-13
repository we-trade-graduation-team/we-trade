// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'email',
    'name',
    'presence',
    'lastSeen',
    'isEmailVerified'
  ]);
  return User(
    isEmailVerified: json['isEmailVerified'] as bool?,
    email: json['email'] as String?,
    name: json['name'] as String?,
    photoURL: json['avatarUrl'] as String?,
    phoneNumber: json['phone'] as String?,
    presence: json['presence'] as bool?,
    lastSeen: json['lastSeen'] as int?,
    searchHistory: (json['searchHistory'] as List<dynamic>?)
        ?.map((e) => UserSearchHistory.fromJson(e as Map<String, dynamic>))
        .toList(),
    keywordHistory: (json['keywordHistory'] as List<dynamic>?)
        ?.map((e) => UserKeywordHistory.fromJson(e as Map<String, dynamic>))
        .toList(),
    categoryHistory: (json['categoryHistory'] as List<dynamic>?)
        ?.map((e) => UserCategoryHistory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'avatarUrl': instance.photoURL,
      'phone': instance.phoneNumber,
      'presence': instance.presence,
      'lastSeen': instance.lastSeen,
      'isEmailVerified': instance.isEmailVerified,
      'searchHistory': instance.searchHistory?.map((e) => e.toJson()).toList(),
      'keywordHistory':
          instance.keywordHistory?.map((e) => e.toJson()).toList(),
      'categoryHistory':
          instance.categoryHistory?.map((e) => e.toJson()).toList(),
    };
