import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../my_special_offer_card/my_special_offer_card.dart';

/// This allows the `UserSpecialOfferCard` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user_special_offer_card.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents some descriptive information about a Category
/// which has a special offer.
class UserSpecialOfferCard extends MySpecialOfferCard {
  UserSpecialOfferCard({
    required String category,
    required String photoUrl,
    int numberOfBrands = 0,
  }) : super(
            category: category,
            photoUrl: photoUrl,
            numberOfBrands: numberOfBrands);

  /// A necessary factory constructor for creating a new UserSpecialOfferCard instance
  /// from a map. Pass the map to the generated `_$UserSpecialOfferCardFromJson()` constructor.
  /// The constructor is named after the source class, in this case, UserSpecialOfferCard.
  factory UserSpecialOfferCard.fromJson(Map<String, dynamic> json) =>
      _$UserSpecialOfferCardFromJson(json);

  factory UserSpecialOfferCard.fromDocumentSnapshot(
          DocumentSnapshot snapshot) =>
      _$UserSpecialOfferCardFromJson(snapshot.data() as Map<String, dynamic>)
        ..categoryId = snapshot.id;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserSpecialOfferCardToJson`.
  Map<String, dynamic> toJson() {
    final json = _$UserSpecialOfferCardToJson(this);
    json.removeWhere((key, dynamic value) => key == 'categoryId');
    return json;
  }
}
