import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  Address({
   required this.city,
   required this.district,
   required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);


  Map<String, dynamic> toJson() => _$AddressToJson(this);
  
  @JsonKey(required: true)
  final String? city;


  @JsonKey(required: true)
  final String? district;


  @JsonKey(required: true)
  final String? address;
}
