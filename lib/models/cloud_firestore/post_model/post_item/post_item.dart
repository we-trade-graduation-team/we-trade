import 'package:json_annotation/json_annotation.dart';
import '../post_item_address/post_item_address.dart';

part 'post_item.g.dart';

@JsonSerializable(explicitToJson: true)
class PostItem {
  PostItem({
    required this.condition,
    required this.description,
    required this.addressInfo,
    this.keywords,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) =>
      _$PostItemFromJson(json);

  factory PostItem.initialData() => PostItem(
        condition: '',
        description: '',
        addressInfo: PostItemAddress.initialData(),
      );

  @JsonKey(required: true)
  final String condition;

  @JsonKey(required: true)
  final String description;

  @JsonKey(required: true)
  final PostItemAddress addressInfo;

  final List<String>? keywords;

  Map<String, dynamic> toJson() => _$PostItemToJson(this);
}
