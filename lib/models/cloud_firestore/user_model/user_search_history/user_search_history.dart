import 'package:json_annotation/json_annotation.dart';

part 'user_search_history.g.dart';

@JsonSerializable(explicitToJson: true)

// Represents user's search history
class UserSearchHistory {
  UserSearchHistory({
    required this.searchTerm,
    this.times = 1,
  });

  factory UserSearchHistory.fromJson(Map<String, dynamic> json) =>
      _$UserSearchHistoryFromJson(json);

  @JsonKey(required: true)
  final String searchTerm;

  @JsonKey(required: true, defaultValue: 1)
  int times;

  Map<String, dynamic> toJson() => _$UserSearchHistoryToJson(this);
}
