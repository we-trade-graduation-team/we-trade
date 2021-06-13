import 'package:json_annotation/json_annotation.dart';

part 'post_card_item.g.dart';

@JsonSerializable(explicitToJson: true)

class PostCardItem {
  PostCardItem({
    required this.image,
    required this.condition,
    required this.district,
    required this.price,
  });

  factory PostCardItem.fromJson(Map<String, dynamic> json) =>
      _$PostCardItemFromJson(json);

  @JsonKey(required: true)
  final String image;

  @JsonKey(required: true)
  final String condition;

  @JsonKey(required: true)
  final String district;

  @JsonKey(required: true)
  final double price;

  Map<String, dynamic> toJson() => _$PostCardItemToJson(this);
}
