import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';
import '../models/arguments/shared/post_details_arguments.dart';
import '../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../providers/loading_overlay_provider.dart';
import '../services/firestore/firestore_database.dart';
import '../ui/home_features/post_details_screen/post_details_screen.dart';
import '../utils/routes/routes.dart';
// import '../ui/home_features/post_details_screen/post_details_screen.dart';
// // import '../utils/routes/routes.dart';

// final tempProduct = Product(
//   id: 1,
//   images: [
//     'https://images.unsplash.com/photo-1605899435973-ca2d1a8861cf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
//     'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=598&q=80',
//     'https://images.unsplash.com/photo-1529448155365-b176d2c6906b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
//     'https://images.unsplash.com/photo-1529154691717-3306083d869e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
//   ],
//   tradeForCategory: tradeForList,
//   title: 'Wireless Controller for PS4™ whole new level',
//   price: 64.99,
//   description: description,
//   condition: condition,
//   productLocation: location,
//   ownerLocation: location,
//   isFavourite: true,
//   isPopular: true,
//   owner: demoUsers[1],
//   questions: demoQuestions,
// );

// final tempPostCardItem = PostCardItem(
//     image:
//         'https://images.unsplash.com/photo-1605899435973-ca2d1a8861cf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
//     condition: 'mới',
//     district: 'quận 5',
//     price: 300);

// final tempPostCardList = <PostCard>[
//   PostCard(
//       postId: '8Dzp1L2GBTENRWaMNJuV',
//       item: tempPostCardItem,
//       title: 'sản phẩm tạm'),
//   PostCard(
//       postId: 'znR6eLnm2KpWBseKI7aJ',
//       item: tempPostCardItem,
//       title: 'sản phẩm tạm'),
// ];

// bool _isNumeric(String? s) {
//   if (s == null) {
//     return false;
//   }
//   return double.tryParse(s) != null;
// }

class ItemPostCard extends StatefulWidget {
  const ItemPostCard({
    Key? key,
    required this.postCard,
    this.isNavigateToDetailScreen = true,
  }) : super(key: key);

  final PostCard postCard;
  final bool isNavigateToDetailScreen;

  @override
  _ItemPostCardState createState() => _ItemPostCardState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<PostCard>('postCard', postCard));
    properties.add(DiagnosticsProperty<bool>(
        'isNavigateToDetailScreen', isNavigateToDetailScreen));
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

    Widget buildContent() {
      return Container(
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
                child: CachedNetworkImage(
                  imageUrl: widget.postCard.item.image,
                  imageBuilder: (_, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (_, __) => Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  errorWidget: (_, __, dynamic ___) => const Icon(Icons.error),
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
                            '${widget.postCard.item.price.toInt()} đ',
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
      );
    }

    return !widget.isNavigateToDetailScreen
        ? buildContent()
        : GestureDetector(
            onTap: _onTap,
            child: buildContent(),
          );
  }

  Future<void> _onTap() async {
    final _loadingOverlayProvider = context.read<LoadingOverlayProvider>();

    _loadingOverlayProvider.updateLoading(
      isLoading: true,
    );

    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _postId = widget.postCard.postId!;

    final _post = await _firestoreDatabase.getPost(
      postId: _postId,
    );

    final _ownerId = _post.owner;

    // Create postDetailsArguments param
    final _postDetailsArguments = PostDetailsArguments(
      postId: _postId,
      ownerId: _ownerId,
    );

    // Navigate to post details screen
    await _navigateToPostDetailsScreen(
      arguments: _postDetailsArguments,
    );

    _loadingOverlayProvider.updateLoading(
      isLoading: false,
    );

    await Future.wait([
      // Increase view by 1
      _firestoreDatabase.increasePostCardView(postId: _postId),
      // Update current user's keyword history
      _firestoreDatabase.updateCurrentUserKeywordHistory(postId: _postId),
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
