import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
import '../../../models/product/temp_class.dart';
import '../../../screens/account_features/post_management/hide_post_screen.dart';
import '../account/account_screen.dart';
import '../utils.dart';
import 'custom_overlay_icon_button.dart';
import 'trading_prod_overlay.dart';

class TradingProductCard extends StatelessWidget {
  TradingProductCard({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.dateTime,
    required this.isHiddenPost,
  }) : super(key: key);

  final String id;
  final String name;
  final String price;
  final DateTime dateTime;
  final bool isHiddenPost;

  final referenceDatabase = AccountScreen.localRefDatabase;
  final userID = AccountScreen.localUserID;

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
        }).then((value) {
          // setState(() {
          //   _isLoaded = true;
          // });
        });
      });
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deletePost = OverlayItem(
      text: 'Xóa',
      iconData: Icons.delete,
      handleFunction: () async {
        await showMyConfirmationDialog(
            context: context,
            title: 'Thông báo',
            content: 'Bạn có chắc muốn xóa bài đăng này không?',
            onConfirmFunction: () {
              _removePost(id);
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
        text: 'Ẩn tin',
        iconData: Icons.visibility_off,
        handleFunction: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: RouteSettings(name: HidePostScreen.routeName, arguments: {
              'id': id,
            }),
            screen: const HidePostScreen(),
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      deletePost,
    ];
    final overlayItemsOfHiddenPosts = [
      deletePost,
    ];

    return GestureDetector(
      onTap: () {
        // print('product tapped');
      },
      child: Container(
        // margin: const EdgeInsets.fromLTRB(15, 3, 15, 3),
        margin: const EdgeInsets.fromLTRB(15, 3, 8, 3),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: const BoxDecoration(
          //color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: kTextColor,
              width: 0.2,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.26,
                  height: height * 0.15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      //TODO:change image source
                      productsData[0].images[0],
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
                        name,
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
                      '\$ $price',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CustomOverlayIconButton(
                      iconData: Icons.more_vert,
                      overlayItems: isHiddenPost
                          ? overlayItemsOfHiddenPosts
                          : overlayItemsOfVisiblePosts,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  DateFormat.yMMMMd('en_US')
                      .add_jm()
                      .format(dateTime)
                      .toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isHiddenPost', isHiddenPost));
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('price', price));
    properties.add(DiagnosticsProperty<DateTime>('dateTime', dateTime));
    properties.add(DiagnosticsProperty<DocumentReference<Map<String, dynamic>>>(
        'referenceDatabase', referenceDatabase));
    properties.add(StringProperty('userID', userID));
    properties.add(StringProperty('postID', id));
  }
}
