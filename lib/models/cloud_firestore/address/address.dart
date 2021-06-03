import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Address` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'address.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
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

  /// A necessary factory constructor for creating a new Address instance
  /// from a map. Pass the map to the generated `_$AddressFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Address.
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

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$AddressToJson`.
  Map<String, dynamic> toJson() {
    final json = _$AddressToJson(this);
    json.removeWhere((key, dynamic value) => key == 'addressId');
    return json;
  }
}
