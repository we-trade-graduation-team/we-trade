import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user_category_history/user_category_history.dart';
import '../user_keyword_history/user_keyword_history.dart';
import '../user_search_history/user_search_history.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents information about a User.
class User {
  User({
    this.isEmailVerified = false,
    this.legit = 0,
    this.email,
    this.name,
    this.uid,
    this.avatarUrl,
    this.phoneNumber,
    this.presence,
    this.lastSeen,
    this.searchHistory,
    this.keywordHistory,
    this.categoryHistory,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$UserFromJson(snapshot.data() as Map<String, dynamic>)
        ..uid = snapshot.id;

  factory User.initialData() => User();

  @JsonKey(ignore: true)
  String? uid;

  @JsonKey(required: true)
  final String? email;

  @JsonKey(required: true)
  String? name;

  @JsonKey(required: true)
  final String? avatarUrl;

  @JsonKey(required: true)
  final String? phoneNumber;

  @JsonKey(required: true)
  bool? presence;

  @JsonKey(required: true)
  int? lastSeen;

  @JsonKey(required: true)
  final bool? isEmailVerified;

  @JsonKey(defaultValue: 0)
  double legit;

  final String? location;

  final List<UserSearchHistory>? searchHistory;

  final List<UserKeywordHistory>? keywordHistory;

  final List<UserCategoryHistory>? categoryHistory;

  Map<String, dynamic> toJson() {
    final json = _$UserToJson(this);
    json.removeWhere((key, dynamic value) => key == 'uid');
    return json;
  }
}
