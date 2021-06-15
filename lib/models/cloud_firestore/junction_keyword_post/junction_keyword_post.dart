import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'junction_keyword_post.g.dart';

@JsonSerializable(explicitToJson: true)

// Represent junction between postId and keywordId
class JunctionKeywordPost {
  JunctionKeywordPost({
    required this.keywordId,
    required this.postId,
  });

  factory JunctionKeywordPost.fromJson(Map<String, dynamic> json) =>
      _$JunctionKeywordPostFromJson(json);

  factory JunctionKeywordPost.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$JunctionKeywordPostFromJson(snapshot.data() as Map<String, dynamic>);

  @JsonKey(required: true)
  final String keywordId;

  @JsonKey(required: true)
  final String postId;

  Map<String, dynamic> toJson() => _$JunctionKeywordPostToJson(this);
}
