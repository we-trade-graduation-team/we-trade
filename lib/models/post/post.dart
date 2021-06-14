import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import './category/category.dart';
import './item/item.dart';

part 'post.g.dart';
@JsonSerializable(explicitToJson: true)
class Post {
  Post(this.name, this.isHidden, this.owner, this.creatAt, this.category,
      this.item, this.imagesUrl, this.tradeForList);
  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);
      factory Post.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostFromJson(snapshot.data() as Map<String, dynamic>)
        ..postID = snapshot.id;
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @JsonKey(ignore: true)
  String? postID;
  final String name;
  final String owner;
  final String creatAt;
  final Category category;
  final Item item;
  final List<String> imagesUrl;
  final List<String> tradeForList;
  final bool isHidden;
}
