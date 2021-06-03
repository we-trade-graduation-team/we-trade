import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../ui/home_features/detail_screen/user_rating_card.dart';
import '../address/address.dart';
import '../post_card/post_card.dart';
import '../post_question/post_question.dart';

/// This allows the `PostDetails` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'post_details.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

/// Represents detail information about a Post.
class PostDetails {
  PostDetails({
    required this.postOwnerId,
    required this.title,
    required this.itemImages,
    required this.itemCondition,
    required this.tradeForList,
    required this.itemAddress,
    required this.ratings,
    required this.questions,
    required this.itemPrice,
    required this.ownerAvatarURL,
    required this.ownerUsername,
    required this.ownerLastSeen,
    required this.postOwnerOtherPostCards,
    required this.similarPostCards,
    required this.userMayAlsoLikePostCards,
    this.description,
  }) : assert(ratings.length == numberOfUserRatingCard,
            'ratings length must be equal to numberOfUserRatingCard');

  /// A necessary factory constructor for creating a new PostDetails instance
  /// from a map. Pass the map to the generated `_$PostDetailsFromJson()` constructor.
  /// The constructor is named after the source class, in this case, PostDetails.
  factory PostDetails.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsFromJson(json);

  factory PostDetails.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      _$PostDetailsFromJson(snapshot.data() as Map<String, dynamic>);

  // final String postId;

  @JsonKey(required: true)
  final String postOwnerId;

  @JsonKey(required: true)
  final List<String> itemImages;

  @JsonKey(required: true)
  final String title;

  @JsonKey(required: true)
  final double itemPrice;

  @JsonKey(required: true)
  final double itemCondition;

  @JsonKey(required: true)
  final Address itemAddress;

  @JsonKey(required: true)
  final List<String> tradeForList;

  final String? description;

  @JsonKey(required: true)
  final String ownerAvatarURL;

  @JsonKey(required: true)
  final String ownerUsername;

  @JsonKey(required: true)
  final DateTime ownerLastSeen;

  @JsonKey(required: true)
  final Map<String, double> ratings;

  @JsonKey(required: true)
  final List<PostQuestion> questions;

  @JsonKey(required: true)
  final List<PostCard> postOwnerOtherPostCards;

  @JsonKey(required: true)
  final List<PostCard> similarPostCards;

  @JsonKey(required: true)
  final List<PostCard> userMayAlsoLikePostCards;

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PostDetailsToJson`.
  Map<String, dynamic> toJson() => _$PostDetailsToJson(this);
}
