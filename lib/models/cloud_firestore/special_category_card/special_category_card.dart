import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'special_category_card.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents some descriptive information about a Category
/// which has a special offer.
class SpecialCategoryCard {
  SpecialCategoryCard({
    required this.category,
    required this.photoUrl,
    this.view = 0,
    this.categoryId,
  });

  factory SpecialCategoryCard.fromJson(Map<String, dynamic> json) =>
      _$SpecialCategoryCardFromJson(json);

  factory SpecialCategoryCard.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$SpecialCategoryCardFromJson(snapshot.data() as Map<String, dynamic>)
        ..categoryId = snapshot.id;

  @JsonKey(ignore: true)
  String? categoryId;

  @JsonKey(required: true)
  final String category;

  @JsonKey(required: true)
  final String photoUrl;

  @JsonKey(required: true, defaultValue: 0)
  final int view;

  Map<String, dynamic> toJson() {
    final json = _$SpecialCategoryCardToJson(this);
    json.removeWhere((key, dynamic value) => key == 'categoryId');
    return json;
  }
}
