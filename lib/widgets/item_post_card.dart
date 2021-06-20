import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

// import '../app_localizations.dart';
import '../app_localizations.dart';
import '../models/arguments/shared/post_details_arguments.dart';
import '../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../services/firestore/firestore_database.dart';
import '../ui/home_features/post_details_screen/post_details_screen.dart';
import '../utils/routes/routes.dart';

class ItemPostCard extends StatefulWidget {
  const ItemPostCard({
    Key? key,
    required this.postCard,
  }) : super(key: key);

  final PostCard postCard;

  @override
  _ItemPostCardState createState() => _ItemPostCardState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<PostCard>('postCard', postCard));
  }
}

class _ItemPostCardState extends State<ItemPostCard> {
  @override
  Widget build(BuildContext context) {
    final _appLocalization = AppLocalizations.of(context);

    final _districtText = _appLocalization.translate('itemPostCardTxtDistrict');

    var _districtTextToShow =
        widget.postCard.item.district.replaceAll('Thành phố', '');

    if (_isNumeric(_districtTextToShow)) {
      _districtTextToShow = '$_districtText $_districtTextToShow';
    }

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        // color: Colors.blue,
        width: 160,
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.postCard.item.image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.postCard.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.postCard.item.condition,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .color!
                                  .withOpacity(0.8),
                            ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${widget.postCard.item.price}',
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.190,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(0.5),
                                ),
                                child: Text(
                                  _districtTextToShow,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTap() async {
    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _postId = widget.postCard.postId!;

    // Get post owner id
    final _postOwnerId = await _firestoreDatabase.getPostOwnerId(
      postId: _postId,
    );

    // Get this post details
    final _postDetails = await _firestoreDatabase.getPostDetails(
      postId: _postId,
    );

    // Check if this post is one of current user's favorite posts
    final _isCurrentUserFavoritePost =
        await _firestoreDatabase.isFavoritePostOfCurrentUser(
      postId: _postId,
    );

    // Check if current user is a follower of post owner
    final _isCurrentUserAFollowerOfPostOwner =
        await _firestoreDatabase.isCurrentUserAFollowerOfUser(
      userId: _postOwnerId,
    );

    // Get similar postCards
    final _similarPostCards =
        await _firestoreDatabase.getPostDetailsScreenSimilarPostCards(
      postId: _postId,
    );

    // Get this post's owner other postCards
    final _postOwnerOtherPostCards =
        await _firestoreDatabase.getPostCardsByUserId(
      userId: _postOwnerId,
    );

    // Remove this post card
    _postOwnerOtherPostCards
        .removeWhere((postCard) => postCard.postId == _postId);

    // Get postCards that current user may also like
    final _postCardsCurrentUserMayAlsoLike = await _firestoreDatabase
        .getPostDetailsPostCardsCurrentUserMayAlsoLike();

    // Create postDetailsArguments param
    final _postDetailsArguments = PostDetailsArguments(
      postDetails: _postDetails,
      isCurrentUserFavoritePost: _isCurrentUserFavoritePost,
      isCurrentUserAFollowerOfPostOwner: _isCurrentUserAFollowerOfPostOwner,
      similarPostCards: _similarPostCards,
      postOwnerOtherPostCards: _postOwnerOtherPostCards,
      postCardsCurrentUserMayAlsoLike: _postCardsCurrentUserMayAlsoLike,
    );

    await Future.wait([
      // Increase view by 1
      _firestoreDatabase.increasePostCardView(postId: _postId),
      // Update current user's keyword history
      _firestoreDatabase.updateCurrentUserKeywordHistory(postId: _postId),
      // Navigate to post details screen
      _navigateToPostDetailsScreen(arguments: _postDetailsArguments),
    ]);
  }

  Future<void> _navigateToPostDetailsScreen({
    required PostDetailsArguments arguments,
  }) async {
    return pushNewScreenWithRouteSettings<void>(
      context,
      screen: const PostDetailsScreen(),
      settings: RouteSettings(
        name: Routes.postDetailScreenRouteName,
        arguments: arguments,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  bool _isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
