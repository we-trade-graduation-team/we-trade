import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../models/arguments/shared/post_details_arguments.dart';
import '../../../providers/loading_overlay_provider.dart';
import '../../../services/firestore/firestore_database.dart';
import '../../../services/post_feature/post_service_algolia.dart';
import '../../../utils/helper/flash/flash_helper.dart';
import '../../../utils/routes/routes.dart';
import '../../posting_features/update_items/update_post_step_one.dart';
import '../../shared_features/post_details_screen/post_details_screen.dart';
import '../desired_post_screen/desired_post_screen.dart';
import '../post_management/hide_post_screen.dart';
import '../utils.dart';
import 'custom_overlay_icon_button.dart';
import 'trading_prod_overlay.dart';

class TradingProductCard extends StatefulWidget {
  const TradingProductCard({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.dateTime,
    required this.isHiddenPost,
    required this.tradeForList,
    required this.priority,
  }) : super(key: key);

  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String priority;
  final DateTime dateTime;
  final bool isHiddenPost;
  final List tradeForList;

  @override
  _TradingProductCardState createState() => _TradingProductCardState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<dynamic>('tradeForList', tradeForList));
    properties.add(StringProperty('price', price));
    properties.add(DiagnosticsProperty<DateTime>('dateTime', dateTime));
    properties.add(StringProperty('imageUrl', imageUrl));
    properties.add(StringProperty('id', id));
    properties.add(DiagnosticsProperty<bool>('isHiddenPost', isHiddenPost));
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('priority', priority));
  }
}

class _TradingProductCardState extends State<TradingProductCard> {
  final referenceDatabase = FirebaseFirestore.instance;

  final userID = FirebaseAuth.instance.currentUser!.uid;

  final List<String> desiredPosts = [];
  late List<String> splitTradeForList = [];

  Future<void> _removePost(String postID) async {
    try {
      await referenceDatabase
          .collection('users')
          .doc(userID)
          .get()
          .then((documentSnapshot) async {
        final _user = documentSnapshot.data();
        final hiddenPosts = _user!['hiddenPosts'] as List;
        final posts = _user['posts'] as List;

        hiddenPosts.remove(postID);
        posts.remove(postID);
        await referenceDatabase.collection('users').doc(userID).update({
          'hiddenPosts': hiddenPosts,
          'posts': posts,
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _reShowPost(String postID) async {
    try {
      await referenceDatabase
          .collection('users')
          .doc(userID)
          .get()
          .then((documentSnapshot) async {
        final _user = documentSnapshot.data();
        final hiddenPosts = _user!['hiddenPosts'] as List;
        final posts = _user['posts'] as List;
        final res = hiddenPosts.remove(postID);

        if (res) {
          posts.add(postID);
          await referenceDatabase
              .collection('posts')
              .doc(postID)
              .update({'isHidden': false});

          await referenceDatabase.collection('users').doc(userID).update({
            'hiddenPosts': hiddenPosts,
            'posts': posts,
          });
        }
      });

      final algoliaService = PostServiceAlgolia();
      await algoliaService.updateIsHiddentPost(postId: postID, isHidden: false);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> navigateToDetailScreen() async {
    final _loadingOverlayProvider = context.read<LoadingOverlayProvider>();

    _loadingOverlayProvider.updateLoading(isLoading: true);

    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _isPostExists = await _firestoreDatabase.checkIfPostExists(
      postId: widget.id,
    );

    if (!_isPostExists) {
      _loadingOverlayProvider.updateLoading(isLoading: false);

      return FlashHelper.showDialogFlash(
        context,
        title: const Text('Bài đăng không còn tồn tại'),
        content: const Text('Có vẻ có lỗi hoặc bài đăng của bạn đã bị xóa'),
        showBothAction: false,
      );
    }

    final _postDetailsArguments = PostDetailsArguments(
      postId: widget.id,
      ownerId: userID,
    );

    _loadingOverlayProvider.updateLoading(isLoading: false);

    return pushNewScreenWithRouteSettings<void>(
      context,
      screen: const PostDetailsScreen(),
      settings: RouteSettings(
        name: Routes.postDetailScreenRouteName,
        arguments: _postDetailsArguments,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  void initState() {
    splitTradeForList = splitStrList(widget.tradeForList);

    super.initState();
  }

  Future<void> _findRelatedPost() async {
    desiredPosts.clear();
    try {
      await referenceDatabase
          .collection('posts')
          .get()
          .then((querySnapshot) async {
        final posts = querySnapshot.docs;
        // ignore: avoid_function_literals_in_foreach_calls
        posts.forEach((post) {
          final _id = post.id;
          final name = post['name'].toString();
          if (checkIfContains(splitTradeForList, name)) {
            desiredPosts.add(_id);
          }
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deletePostOverlayItem = OverlayItem(
      text: 'Xóa',
      iconData: Icons.delete,
      handleFunction: () async {
        await showMyConfirmationDialog(
            context: context,
            title: 'Thông báo',
            content: 'Bạn có chắc muốn xóa bài đăng này không?',
            onConfirmFunction: () {
              _removePost(widget.id);
              Navigator.of(context).pop();
            },
            onCancelFunction: () {
              Navigator.of(context).pop();
            });
      },
    );
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final overlayItemsOfVisiblePosts = [
      OverlayItem(
        text: 'Tìm bài đăng mong muốn',
        iconData: Icons.find_in_page,
        handleFunction: () async {
          await _findRelatedPost();
          await pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: Routes.desiredPostScreenRouteName,
            ),
            screen: DesiredPostScreen(posts: desiredPosts),
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      OverlayItem(
        text: 'Ẩn tin',
        iconData: Icons.visibility_off,
        handleFunction: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings:
                RouteSettings(name: Routes.hidePostScreenRouteName, arguments: {
              'id': widget.id,
            }),
            screen: const HidePostScreen(),
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      OverlayItem(
        text: 'Đổi thông tin bài đăng',
        iconData: Icons.change_circle,
        handleFunction: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
                name: Routes.updateItemStepOneScreenRouteName),
            screen: UpdatePostOne(postId: widget.id),
            // withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      deletePostOverlayItem,
    ];
    final overlayItemsOfHiddenPosts = [
      OverlayItem(
        text: 'Hiện tin',
        iconData: Icons.visibility,
        handleFunction: () async {
          await showMyConfirmationDialog(
              context: context,
              title: 'Thông báo',
              content:
                  'Bạn có chắc muốn hiển thị bài đăng này không? Người dùng khác có thể xem bài đăng này của bạn.',
              onConfirmFunction: () {
                _reShowPost(widget.id);
                Navigator.of(context).pop();
              },
              onCancelFunction: () {
                Navigator.of(context).pop();
              });
        },
      ),
      deletePostOverlayItem,
    ];

    return GestureDetector(
      onTap: navigateToDetailScreen,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 3, 8, 3),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          //color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.2,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.26,
                  height: height * 0.15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.45,
                      child: Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$ ${widget.price}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CustomOverlayIconButton(
                      iconData: Icons.more_vert,
                      overlayItems: widget.isHiddenPost
                          ? overlayItemsOfHiddenPosts
                          : overlayItemsOfVisiblePosts,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                  ),
                  child: Text(
                    'Điểm ưu tiên: ${widget.priority}',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    DateFormat.yMMMMd('en_US')
                        .add_jm()
                        .format(widget.dateTime)
                        .toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FirebaseFirestore>(
        'referenceDatabase', referenceDatabase));
    properties.add(StringProperty('userID', userID));
    properties.add(IterableProperty<String>('desiredPosts', desiredPosts));
    properties
        .add(IterableProperty<String>('splitTradeForList', splitTradeForList));
  }
}
