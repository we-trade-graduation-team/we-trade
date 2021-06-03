// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['email', 'presence', 'lastSeen', 'searchHistory']);
  return User(
    email: json['email'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    displayName: json['username'] as String?,
    photoURL: json['avatarUrl'] as String?,
    phoneNumber: json['phone'] as String?,
    dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
    presence: json['presence'] as bool?,
    lastSeen: json['lastSeen'] as int?,
    searchHistory: (json['searchHistory'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'username': instance.displayName,
      'avatarUrl': instance.photoURL,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phoneNumber,
      'dob': instance.dob?.toIso8601String(),
      'presence': instance.presence,
      'lastSeen': instance.lastSeen,
      'searchHistory': instance.searchHistory,
    };
