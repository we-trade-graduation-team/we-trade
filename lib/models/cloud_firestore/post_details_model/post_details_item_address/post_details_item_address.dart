import 'package:json_annotation/json_annotation.dart';

part 'post_details_item_address.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents information about an Address.
class PostDetailsItemAddress {
  PostDetailsItemAddress({
    required this.address,
    required this.city,
    required this.district,
  });

  factory PostDetailsItemAddress.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsItemAddressFromJson(json);

  @JsonKey(required: true)
  final String address;

  @JsonKey(required: true)
  final String district;

  @JsonKey(required: true)
  final String city;

  @override
  String toString() {
    return '$address, $district, $city';
  }

  Map<String, dynamic> toJson() => _$PostDetailsItemAddressToJson(this);
}
