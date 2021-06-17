import 'package:json_annotation/json_annotation.dart';

part 'user_keyword_history.g.dart';

@JsonSerializable(explicitToJson: true)

// Represents user's keyword history
class UserKeywordHistory {
  UserKeywordHistory({
    required this.keywordId,
    this.times = 1,
  });

  factory UserKeywordHistory.fromJson(Map<String, dynamic> json) =>
      _$UserKeywordHistoryFromJson(json);

  UserKeywordHistory.clone(UserKeywordHistory source)
      : keywordId = source.keywordId,
        times = source.times;

  @JsonKey(required: true)
  final String keywordId;

  @JsonKey(required: true, defaultValue: 1)
  int times;

  Map<String, dynamic> toJson() => _$UserKeywordHistoryToJson(this);
}
