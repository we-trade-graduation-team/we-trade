import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `PostCard` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'post_card.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents some descriptive information about a Post.
class PostCard {
  PostCard({
    required this.title,
    required this.image,
    required this.itemCondition,
    required this.itemPrice,
    required this.district,
    required this.view,
    this.postId,
  });

  /// A necessary factory constructor for creating a new PostCard instance
  /// from a map. Pass the map to the generated `_$PostCardFromJson()` constructor.
  /// The constructor is named after the source class, in this case, PostCard.
  factory PostCard.fromJson(Map<String, dynamic> json) =>
      _$PostCardFromJson(json);

  factory PostCard.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostCardFromJson(snapshot.data() as Map<String, dynamic>)
        ..postId = snapshot.id;

  @JsonKey(ignore: true)
  String? postId;

  /// 1. When `true` tell json_serializable that JSON must contain the key,
  /// If the key doesn't exist, an exception is thrown.
  /// 2. Tell json_serializable that "imageUrl" should be
  /// mapped to this property.
  @JsonKey(
    required: true,
    name: 'imageUrl',
  )
  final String image;

  @JsonKey(required: true)
  final String title;

  /// 1. When `true` tell json_serializable that JSON must contain the key,
  /// If the key doesn't exist, an exception is thrown.
  /// 2. Tell json_serializable that "condition" should be
  /// mapped to this property.
  @JsonKey(
    required: true,
    name: 'condition',
  )
  final String itemCondition;

  /// 2. Tell json_serializable that "price" should be
  /// mapped to this property.
  @JsonKey(
    required: true,
    name: 'price',
  )
  final double itemPrice;

  @JsonKey(required: true)
  final String district;

  @JsonKey(required: true)
  final int view;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PostCardToJson`.
  Map<String, dynamic> toJson() {
    final json = _$PostCardToJson(this);
    json.removeWhere((key, dynamic value) => key == 'postId');
    return json;
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PostCardToJson`.
  // Map<String, dynamic> toJson() => _$PostCardToJson(this);
}
