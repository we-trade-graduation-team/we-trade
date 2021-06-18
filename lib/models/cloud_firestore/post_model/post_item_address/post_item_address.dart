import 'package:json_annotation/json_annotation.dart';

part 'post_item_address.g.dart';

@JsonSerializable(explicitToJson: true)
class PostItemAddress {
  PostItemAddress({
    required this.city,
    required this.district,
    required this.address,
  });

  factory PostItemAddress.fromJson(Map<String, dynamic> json) =>
      _$PostItemAddressFromJson(json);

  @JsonKey(required: true)
  final String address;

  @JsonKey(required: true)
  final String city;

  @JsonKey(required: true)
  final String district;

  Map<String, dynamic> toJson() => _$PostItemAddressToJson(this);
}
