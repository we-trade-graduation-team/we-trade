import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import './category/category.dart';
import './item/item.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  Post({
    required this.name,
    required this.isHidden,
    required this.ownerId,
    this.creatAt,
    required this.category,
    required this.item,
    required this.imagesUrl,
    required this.tradeForListId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostFromJson(snapshot.data() as Map<String, dynamic>)
        ..postId = snapshot.id;


  Map<String, dynamic> toJson() {
    final json = _$PostToJson(this);
    json.removeWhere((key, dynamic value) => key == 'postId');
    return json;
  }

  @JsonKey(ignore: true)
  String? postId;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final String ownerId;

  @JsonKey(required: true)
  final String? creatAt;

  @JsonKey(required: true)
  final Category category;

  @JsonKey(required: true)
  final Item item;

  @JsonKey(required: true)
  final List<String> imagesUrl;

  @JsonKey(required: true)
  final List<String> tradeForListId;
  
  @JsonKey(required: true)
  final bool isHidden;
}
