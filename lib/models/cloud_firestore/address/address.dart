import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents information about an Address.
class Address {
  Address({
    required this.address,
    required this.cityId,
    required this.district,
    required this.phone,
    this.addressId,
    this.address2,
    this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  factory Address.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$AddressFromJson(snapshot.data() as Map<String, dynamic>)
        ..addressId = snapshot.id;

  @JsonKey(ignore: true)
  String? addressId;

  @JsonKey(required: true)
  final String address;

  final String? address2;

  @JsonKey(required: true)
  final String cityId;

  @JsonKey(required: true)
  final String district;

  final String? postalCode;

  @JsonKey(required: true)
  final String phone;

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
