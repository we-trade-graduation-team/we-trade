import 'package:json_annotation/json_annotation.dart';
import '../post_details_item_address/post_details_item_address.dart';

part 'post_details_item.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents detail information about a Post Viewer.
class PostDetailsItem {
  PostDetailsItem({
    required this.images,
    required this.description,
    required this.condition,
    required this.address,
    required this.price,
    required this.tradeForList,
  });

  factory PostDetailsItem.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsItemFromJson(json);

  @JsonKey(required: true)
  final List<String> images;

  @JsonKey(required: true)
  final String description;

  @JsonKey(required: true)
  final String condition;

  @JsonKey(required: true)
  final PostDetailsItemAddress address;

  @JsonKey(required: true)
  final double price;

  @JsonKey(required: true)
  final List<String> tradeForList;

  Map<String, dynamic> toJson() => _$PostDetailsItemToJson(this);
}
