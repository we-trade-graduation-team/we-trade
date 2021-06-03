import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `SpecialOfferCard` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'special_offer_card.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents some descriptive information about a Category
/// which has a special offer.
class SpecialOfferCard {
  SpecialOfferCard({
    required this.category,
    required this.photoUrl,
    this.numberOfBrands = 0,
    this.categoryId,
  });

  /// A necessary factory constructor for creating a new SpecialOfferCard instance
  /// from a map. Pass the map to the generated `_$SpecialOfferCardFromJson()` constructor.
  /// The constructor is named after the source class, in this case, SpecialOfferCard.
  factory SpecialOfferCard.fromJson(Map<String, dynamic> json) =>
      _$SpecialOfferCardFromJson(json);

  factory SpecialOfferCard.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$SpecialOfferCardFromJson(snapshot.data() as Map<String, dynamic>)
        ..categoryId = snapshot.id;

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

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$SpecialOfferCardToJson`.
  Map<String, dynamic> toJson() {
    final json = _$SpecialOfferCardToJson(this);
    json.removeWhere((key, dynamic value) => key == 'categoryId');
    return json;
  }

  // /// `toJson` is the convention for a class to declare support for serialization
  // /// to JSON. The implementation simply calls the private, generated
  // /// helper method `_$SpecialOfferCardToJson`.
  // Map<String, dynamic> toJson() => _$SpecialOfferCardToJson(this);
}
