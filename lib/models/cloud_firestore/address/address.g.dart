// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['address', 'cityId', 'district', 'phone']);
  return Address(
    address: json['address'] as String,
    cityId: json['cityId'] as String,
    district: json['district'] as String,
    phone: json['phone'] as String,
    address2: json['address2'] as String?,
    postalCode: json['postalCode'] as String?,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address': instance.address,
      'address2': instance.address2,
      'cityId': instance.cityId,
      'district': instance.district,
      'postalCode': instance.postalCode,
      'phone': instance.phone,
    };
