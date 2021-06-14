import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  Category({
    required this.mainCategoryId,
    required this.subCategoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @JsonKey(required: true)
  final String mainCategoryId;

  @JsonKey(required: true)
  final String subCategoryId;
}
