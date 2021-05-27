import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable()
class Address {
  Address({
    required this.street,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  String street;
  String city;

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
