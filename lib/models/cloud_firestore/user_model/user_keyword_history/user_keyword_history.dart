import 'package:json_annotation/json_annotation.dart';

part 'user_keyword_history.g.dart';

@JsonSerializable(explicitToJson: true)

// Represents user's keyword history
class UserKeywordHistory {
  UserKeywordHistory({
    required this.keywordId,
    required this.times,
  });

  factory UserKeywordHistory.fromJson(Map<String, dynamic> json) =>
      _$UserKeywordHistoryFromJson(json);

  @JsonKey(required: true)
  final String keywordId;

  @JsonKey(required: true)
  final int times;

  Map<String, dynamic> toJson() => _$UserKeywordHistoryToJson(this);
}
