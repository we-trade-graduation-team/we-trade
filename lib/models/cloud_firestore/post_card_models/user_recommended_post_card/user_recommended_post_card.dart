import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../my_post_card/my_post_card.dart';

/// This allows the `PostCard` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user_recommended_post_card.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents some descriptive information about a Post.
class UserRecommendedPostCard extends MyPostCard {
  UserRecommendedPostCard({
    required String title,
    required String image,
    required String itemCondition,
    required double itemPrice,
    required String district,
    int? view,
  }) : super(
            title: title,
            image: image,
            itemCondition: itemCondition,
            itemPrice: itemPrice,
            district: district,
            view: view);

  /// A necessary factory constructor for creating a new PostCard instance
  /// from a map. Pass the map to the generated `_$PostCardFromJson()` constructor.
  /// The constructor is named after the source class, in this case, PostCard.
  factory UserRecommendedPostCard.fromJson(Map<String, dynamic> json) =>
      _$UserRecommendedPostCardFromJson(json);

  factory UserRecommendedPostCard.fromDocumentSnapshot(
          DocumentSnapshot snapshot) =>
      _$UserRecommendedPostCardFromJson(snapshot.data() as Map<String, dynamic>)
        ..postId = snapshot.id;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PostCardToJson`.
  Map<String, dynamic> toJson() {
    final json = _$UserRecommendedPostCardToJson(this);
    json.removeWhere((key, dynamic value) => key == 'postId');
    return json;
  }
}
