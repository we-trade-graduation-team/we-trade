import 'package:json_annotation/json_annotation.dart';

part 'user_category_history.g.dart';

@JsonSerializable(explicitToJson: true)

// Represents user's category history
class UserCategoryHistory {
  UserCategoryHistory({
    required this.categoryId,
    this.times = 1,
  });

  factory UserCategoryHistory.fromJson(Map<String, dynamic> json) =>
      _$UserCategoryHistoryFromJson(json);

  @JsonKey(required: true)
  final String categoryId;

  @JsonKey(required: true, defaultValue: 1)
  int times;

  Map<String, dynamic> toJson() => _$UserCategoryHistoryToJson(this);
}
