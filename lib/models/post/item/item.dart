import 'package:json_annotation/json_annotation.dart';

import './address/address.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  Item(this.keyword, this.conditions, this.description, this.address,
      this.price);
      factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
  final List<String> keyword;
  final String conditions;
  final String description;
  final Address address;
  final double price;
}
