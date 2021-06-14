import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_card.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents a Category.
class CategoryCard {
  CategoryCard({
    required this.category,
    required this.iconKey,
    required this.priority,
    this.categoryId,
  });

  factory CategoryCard.fromJson(Map<String, dynamic> json) =>
      _$CategoryCardFromJson(json);

  factory CategoryCard.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$CategoryCardFromJson(snapshot.data() as Map<String, dynamic>)
        ..categoryId = snapshot.id;

  @JsonKey(ignore: true)
  String? categoryId;

  @JsonKey(required: true)
  final String category;

  @JsonKey(required: true, name: 'icon')
  final String iconKey;

  @JsonKey(required: true)
  final int priority;

  Map<String, dynamic> toJson() {
    final json = _$CategoryCardToJson(this);
    json.removeWhere((key, dynamic value) => key == 'categoryId');
    return json;
  }
}
