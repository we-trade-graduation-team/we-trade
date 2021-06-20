import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'junction_user_favorite_post.g.dart';

@JsonSerializable(explicitToJson: true)

// Represent junction between postId and uid

class JunctionUserFavoritePost {
  JunctionUserFavoritePost({
    required this.uid,
    required this.postId,
  });

  factory JunctionUserFavoritePost.fromJson(Map<String, dynamic> json) =>
      _$JunctionUserFavoritePostFromJson(json);

  factory JunctionUserFavoritePost.fromDocumentSnapshot(
          DocumentSnapshot snapshot) =>
      _$JunctionUserFavoritePostFromJson(
          snapshot.data() as Map<String, dynamic>);

  @JsonKey(required: true)
  final String uid;

  @JsonKey(required: true)
  final String postId;

  Map<String, dynamic> toJson() => _$JunctionUserFavoritePostToJson(this);
}
