import 'package:json_annotation/json_annotation.dart';

/// Represents some descriptive information about a Category
/// which has a special offer. 
 class MySpecialOfferCard {
  MySpecialOfferCard({
    required this.category,
    required this.photoUrl,
    this.numberOfBrands = 0,
    this.categoryId,
  });

  @JsonKey(ignore: true)
  String? categoryId;

  @JsonKey(required: true)
  final String category;

  @JsonKey(required: true)
  final String photoUrl;

  /// Tell json_serializable to use "defaultValue" if the JSON doesn't
  /// contain this key or if the value is `null`.
  @JsonKey(defaultValue: 0)
  final int numberOfBrands;
}
