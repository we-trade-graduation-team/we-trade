// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_item_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailsItemAddress _$PostDetailsItemAddressFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['address', 'district', 'city']);
  return PostDetailsItemAddress(
    address: json['address'] as String,
    city: json['city'] as String,
    district: json['district'] as String,
  );
}

Map<String, dynamic> _$PostDetailsItemAddressToJson(
        PostDetailsItemAddress instance) =>
    <String, dynamic>{
      'address': instance.address,
      'district': instance.district,
      'city': instance.city,
    };
