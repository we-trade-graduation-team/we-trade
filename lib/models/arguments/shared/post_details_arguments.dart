import '../../cloud_firestore/post_card_model/post_card/post_card.dart';

import '../../cloud_firestore/post_details_model/post_details/post_details.dart';

class PostDetailsArguments {
  PostDetailsArguments({
    required this.postDetails,
    required this.isCurrentUserFavoritePost,
    required this.isCurrentUserAFollowerOfPostOwner,
    required this.similarPostCards,
    required this.postOwnerOtherPostCards,
    required this.postCardsCurrentUserMayAlsoLike,
  });

  final PostDetails postDetails;
  final bool isCurrentUserFavoritePost;
  final bool isCurrentUserAFollowerOfPostOwner;
  final List<PostCard> similarPostCards;
  final List<PostCard> postOwnerOtherPostCards;
  final List<PostCard> postCardsCurrentUserMayAlsoLike;
}
