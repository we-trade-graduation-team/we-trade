import 'package:json_annotation/json_annotation.dart';

import './address/address.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  Item(
      { this.keyword,
      required this.conditions,
      required this.description,
      required this.address,
      required this.price,});
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  final List<String>? keyword;
  
  @JsonKey(required: true)
  final String conditions;

  @JsonKey(required: true)
  final String description;

  @JsonKey(required: true)
  final Address address;

  @JsonKey(required: true)
  final double price;
}
