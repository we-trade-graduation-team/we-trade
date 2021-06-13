import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../post_details_item/post_details_item.dart';
import '../post_details_owner/post_details_owner.dart';
import '../post_details_viewer/post_details_viewer.dart';

part 'post_details.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents detail information about a Post.
class PostDetails {
  PostDetails({
    required this.title,
    required this.itemInfo,
    required this.ownerInfo,
    required this.viewerInfo,
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsFromJson(json);

  factory PostDetails.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostDetailsFromJson(snapshot.data() as Map<String, dynamic>);

  @JsonKey(required: true)
  final String title;

  @JsonKey(required: true)
  final PostDetailsItem itemInfo;

  @JsonKey(required: true)
  final PostDetailsOwner ownerInfo;

  @JsonKey(required: true)
  final PostDetailsViewer viewerInfo;

  // final List<PostQuestion> questions;

  Map<String, dynamic> toJson() => _$PostDetailsToJson(this);
}
