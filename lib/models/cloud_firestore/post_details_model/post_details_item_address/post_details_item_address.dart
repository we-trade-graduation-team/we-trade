import 'package:json_annotation/json_annotation.dart';

part 'post_details_item_address.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents information about an Address.
class PostDetailsItemAddress {
  PostDetailsItemAddress({
    required this.address,
    required this.city,
    required this.district,
    // this.address2,
  });

  /// A necessary factory constructor for creating a new Address instance
  /// from a map. Pass the map to the generated `_$AddressFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Address.
  factory PostDetailsItemAddress.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsItemAddressFromJson(json);

  // factory PostDetailsItemAddress.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
  //     _$PostDetailsItemAddressFromJson(snapshot.data() as Map<String, dynamic>)
  //       ..addressId = snapshot.id;

  @JsonKey(required: true)
  final String address;

  // final String? address2;

  @JsonKey(required: true)
  final String district;

  @JsonKey(required: true)
  final String city;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$AddressToJson`.
  Map<String, dynamic> toJson() => _$PostDetailsItemAddressToJson(this);
}
