import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'junction_user_follower.g.dart';

@JsonSerializable(explicitToJson: true)

// Represent junction between followerId and uid
class JunctionUserFollower {
  JunctionUserFollower({
    required this.uid,
    required this.followerId,
  });

  factory JunctionUserFollower.fromJson(Map<String, dynamic> json) =>
      _$JunctionUserFollowerFromJson(json);

  factory JunctionUserFollower.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$JunctionUserFollowerFromJson(snapshot.data() as Map<String, dynamic>);

  @JsonKey(required: true)
  final String uid;

  @JsonKey(required: true)
  final String followerId;

  Map<String, dynamic> toJson() => _$JunctionUserFollowerToJson(this);
}
