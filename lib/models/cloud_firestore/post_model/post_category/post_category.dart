import 'package:json_annotation/json_annotation.dart';

part 'post_category.g.dart';

@JsonSerializable(explicitToJson: true)
class PostCategory {
  PostCategory({
    required this.mainCategoryId,
    required this.subCategoryId,
  });

  factory PostCategory.fromJson(Map<String, dynamic> json) =>
      _$PostCategoryFromJson(json);

  @JsonKey(required: true)
  final String mainCategoryId;

  @JsonKey(required: true)
  final String subCategoryId;

  Map<String, dynamic> toJson() => _$PostCategoryToJson(this);
}
