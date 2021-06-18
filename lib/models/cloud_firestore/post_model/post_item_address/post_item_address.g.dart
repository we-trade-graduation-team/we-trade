// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_item_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostItemAddress _$PostItemAddressFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['address', 'city', 'district']);
  return PostItemAddress(
    city: json['city'] as String,
    district: json['district'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$PostItemAddressToJson(PostItemAddress instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'district': instance.district,
    };
