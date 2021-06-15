import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../post_card_item/post_card_item.dart';

part 'post_card.g.dart';

@JsonSerializable(explicitToJson: true)

/// Represents some descriptive information about a Post.
class PostCard {
  PostCard({
    required this.title,
    required this.item,
    this.view = 0,
    this.postId,
  });

  factory PostCard.fromJson(Map<String, dynamic> json) =>
      _$PostCardFromJson(json);

  factory PostCard.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostCardFromJson(snapshot.data() as Map<String, dynamic>)
        ..postId = snapshot.id;

  @JsonKey(ignore: true)
  String? postId;

  @JsonKey(required: true)
  final String title;

  @JsonKey(required: true)
  final PostCardItem item;

  @JsonKey(required: true, defaultValue: 0)
  final int view;

  Map<String, dynamic> toJson() {
    final json = _$PostCardToJson(this);
    json.removeWhere((key, dynamic value) => key == 'postId');
    return json;
  }
}
