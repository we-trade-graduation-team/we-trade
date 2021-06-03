import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `CategoryCard` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'category_card.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents a Category.
class CategoryCard {
  CategoryCard({
    required this.category,
    required this.iconKey,
    required this.priority,
    this.categoryId,
  });

  /// A necessary factory constructor for creating a new CategoryCard instance
  /// from a map. Pass the map to the generated `_$CategoryCardFromJson()` constructor.
  /// The constructor is named after the source class, in this case, CategoryCard.
  factory CategoryCard.fromJson(Map<String, dynamic> json) =>
      _$CategoryCardFromJson(json);

  factory CategoryCard.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$CategoryCardFromJson(snapshot.data() as Map<String, dynamic>)
        ..categoryId = snapshot.id;

  @JsonKey(ignore: true)
  String? categoryId;

  @JsonKey(required: true)
  final String category;

  /// 1. When `true` tell json_serializable that JSON must contain the key,
  /// If the key doesn't exist, an exception is thrown.
  /// 2. Tell json_serializable that "icon" should be
  /// mapped to this property.
  @JsonKey(
    required: true,
    name: 'icon',
  )
  final String iconKey;

  @JsonKey(required: true)
  final int priority;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryCardToJson`.
  Map<String, dynamic> toJson() {
    final json = _$CategoryCardToJson(this);
    json.removeWhere((key, dynamic value) => key == 'categoryId');
    return json;
  }

  // /// `toJson` is the convention for a class to declare support for serialization
  // /// to JSON. The implementation simply calls the private, generated
  // /// helper method `_$CategoryCardToJson`.
  // Map<String, dynamic> toJson() => _$CategoryCardToJson(this);
}
