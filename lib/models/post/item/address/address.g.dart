// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['city', 'district', 'address']);
  return Address(
    city: json['city'] as String?,
    district: json['district'] as String?,
    address: json['address'] as String?,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'city': instance.city,
      'district': instance.district,
      'address': instance.address,
    };
