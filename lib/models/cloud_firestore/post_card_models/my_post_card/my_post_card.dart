import 'package:json_annotation/json_annotation.dart';

/// Represents some descriptive information about a Post.
class MyPostCard {
  MyPostCard({
    required this.title,
    required this.image,
    required this.itemCondition,
    required this.itemPrice,
    required this.district,
    required this.view,
    this.postId,
  });

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

  final int? view;
}
