import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_assets.dart';
import '../post_category/post_category.dart';
import '../post_item/post_item.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)

// Represents information about a Post
class Post {
  Post({
    required this.name,
    required this.owner,
    required this.categoryInfo,
    required this.itemInfo,
    required this.imagesUrl,
    required this.tradeForList,
    required this.price,
    required this.createAt,
    this.priority = 0,
    this.isHidden = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostFromJson(snapshot.data() as Map<String, dynamic>)
        ..postId = snapshot.id;

  factory Post.initialData() => Post(
        name: '',
        owner: '',
        createAt: DateTime.now(),
        categoryInfo: PostCategory.initialData(),
        itemInfo: PostItem.initialData(),
        imagesUrl: [AppAssets.kPostDetailsDefaultCarouselImage],
        tradeForList: [],
        price: 0,
      );

  @JsonKey(ignore: true)
  String? postId;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final String owner;

  @JsonKey(fromJson: _rawDateTime)
  final DateTime createAt;

  static DateTime _rawDateTime(Timestamp t) => t.toDate();

  @JsonKey(required: true)
  final PostCategory categoryInfo;

  @JsonKey(required: true)
  final PostItem itemInfo;

  @JsonKey(required: true)
  final List<String> imagesUrl;

  @JsonKey(required: true)
  final List<String> tradeForList;

  @JsonKey(required: true, defaultValue: false)
  final bool isHidden;

  @JsonKey(required: true)
  final int price;

  @JsonKey(defaultValue: 0)
  final int priority;

  Map<String, dynamic> toJson() {
    final json = _$PostToJson(this);
    json.removeWhere((key, dynamic value) => key == 'postId');
    return json;
  }
}
