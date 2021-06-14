import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  Address(this.city, this.district, this.address);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
    Map<String, dynamic> toJson() => _$AddressToJson(this);

  final String? city;
  final String? district;
  final String? address;
}
