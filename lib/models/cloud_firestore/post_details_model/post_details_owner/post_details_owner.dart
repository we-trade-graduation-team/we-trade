import 'package:json_annotation/json_annotation.dart';

part 'post_details_owner.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents detail information about a Post Owner.
class PostDetailsOwner {
  PostDetailsOwner({
    required this.uid,
    required this.legitimacy,
    required this.avatarURL,
    required this.name,
    required this.lastSeen,
  });

  factory PostDetailsOwner.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsOwnerFromJson(json);

  @JsonKey(required: true)
  final String uid;

  @JsonKey(required: true)
  final double legitimacy;

  @JsonKey(required: true)
  final String avatarURL;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final int lastSeen;

  // other postCards

  Map<String, dynamic> toJson() => _$PostDetailsOwnerToJson(this);
}
