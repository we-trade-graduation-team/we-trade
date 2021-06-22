import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../utils/routes/routes.dart';
import '../../notification_screen/notification.dart';
import '../../notification_screen/notification_screen.dart';
import 'home_screen_icon_button_with_counter.dart';
import 'home_screen_search_bar.dart';
import 'home_screen_special_event_carousel_slider.dart';

List<NotificationData> notes = [];

class HomeScreenAppBar extends StatefulWidget {
  const HomeScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenAppBarState createState() => _HomeScreenAppBarState();
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> getNotificationDatas() async {
    final user = auth.currentUser!;
    final myId = user.uid;
    final _notes = <NotificationData>[];

    final _querySnapshot = await FirebaseFirestore.instance
        .collection('notification')
        .where('userId', isEqualTo: myId)
        .get();

    final _docs = _querySnapshot.docs;

    for (final doc in _docs) {
      var follower = '';
      var offerer = '';
      if (int.parse(doc['type'].toString()) > 1) {
        await Future.wait([
          FirebaseFirestore.instance
              .collection('users')
              .where('objectId', isEqualTo: doc['followerId'].toString())
              .get()
              .then((value) {
            follower = value.docs[0]['name'].toString();
          }),
          FirebaseFirestore.instance
              .collection('users')
              .where('objectId', isEqualTo: doc['offererId'].toString())
              .get()
              .then((value) => offerer = value.docs[0]['name'].toString()),
        ]);
      }
      var title = '';
      var content = '';
      switch (int.parse(doc['type'].toString())) {
        case 0:
          {
            title = 'bài post của bạn đã được đăng';
            content =
                'bài post ${doc['postId'].toString()} của bạn đã được đăng lên hệ thống thành công.';
          }
          break;
        case 1:
          {
            title = 'bài post của bạn đã vi phạm chính sách của hệ thống';
            content =
                'bài post ${doc['postId'].toString()} của bạn đã vi phạm chính sách hệ thống với lý do ${doc['reason'].toString()}. '
                'Chúng tôi mong bạn chú ý hơn trong các bài post tương lai';
          }
          break;
        case 2:
          {
            title = '$offerer mong muốn trao đổi sản phẩm với bạn';
            content =
                '$offerer mong muốn trao đổi bài post ${doc['postId'].toString()} của bạn. Hãy vào phần chat để thảo luận thêm.';
          }
          break;
        default:
          {
            title = '$follower vừa đăng sản phẩm mới';
            content =
                '$follower vừa đăng bài post ${doc['postId'].toString()}.';
          }
          break;
      }
      final data = NotificationData(
        title: title,
        content: content,
        seen: doc['seen'].toString().toLowerCase() == 'true',
        createAt: doc['createAt'].toString(),
        followerId: doc['followerId'].toString(),
        offererId: doc['offererId'].toString(),
        postId: doc['postId'].toString(),
        type: int.parse(doc['type'].toString()),
        reason: doc['reason'].toString(),
      );

      _notes.add(data);
    }

    setState(() {
      notes = _notes;
    });

    // await FirebaseFirestore.instance
    //     .collection('notification')
    //     .where('userId', isEqualTo: myId)
    //     .get()
    //     .then((querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     var follower = '';
    //     var offerer = '';
    //     if (int.parse(doc['type'].toString()) > 1) {
    //       FirebaseFirestore.instance
    //           .collection('users')
    //           .where('objectId', isEqualTo: doc['followerId'].toString())
    //           .get()
    //           .then((value) {
    //         follower = value.docs[0]['name'].toString();
    //       });

    //       FirebaseFirestore.instance
    //           .collection('users')
    //           .where('objectId', isEqualTo: doc['offererId'].toString())
    //           .get()
    //           .then((value) => offerer = value.docs[0]['name'].toString());
    //     }
    //     var title = '';
    //     var content = '';
    //     switch (int.parse(doc['type'].toString())) {
    //       case 0:
    //         {
    //           title = 'bài post của bạn đã được đăng';
    //           content =
    //               'bài post ${doc['postId'].toString()} của bạn đã được đăng lên hệ thống thành công.';
    //         }
    //         break;
    //       case 1:
    //         {
    //           title = 'bài post của bạn đã vi phạm chính sách của hệ thống';
    //           content =
    //               'bài post ${doc['postId'].toString()} của bạn đã vi phạm chính sách hệ thống với lý do ${doc['reason'].toString()}. '
    //               'Chúng tôi mong bạn chú ý hơn trong các bài post tương lai';
    //         }
    //         break;
    //       case 2:
    //         {
    //           title = '$offerer mong muốn trao đổi sản phẩm với bạn';
    //           content =
    //               '$offerer mong muốn trao đổi bài post ${doc['postId'].toString()} của bạn. Hãy vào phần chat để thảo luận thêm.';
    //         }
    //         break;
    //       default:
    //         {
    //           title = '$follower vừa đăng sản phẩm mới';
    //           content =
    //               '$follower vừa đăng bài post ${doc['postId'].toString()}.';
    //         }
    //         break;
    //     }
    //     final data = NotificationData(
    //       title: title,
    //       content: content,
    //       seen: doc['seen'].toString().toLowerCase() == 'true',
    //       createAt: doc['createAt'].toString(),
    //       followerId: doc['followerId'].toString(),
    //       offererId: doc['offererId'].toString(),
    //       postId: doc['postId'].toString(),
    //       type: int.parse(doc['type'].toString()),
    //       reason: doc['reason'].toString(),
    //     );

    //     _notes.add(data);
    //   });
    //   setState(() {
    //     notes = _notes;
    //   });
    // });
    return true;
  }

  @override
  void initState() {
    super.initState();
    // print(true);
    getNotificationDatas().then((value) {
      // print('get notification data');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const defaultToolbarHeight = 56.0;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: AppDimens.kHomeScreenFlexibleSpaceExpandedHeight,
      toolbarHeight: defaultToolbarHeight + 20,
      pinned: true,
      title: const HomeScreenSearchBar(),
      titleSpacing: 0,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.015,
            horizontal: size.width * 0.01,
          ),
          child: HomeScreenIconButtonWithCounter(
            icon: 'bell',
            numOfItems: notes.length,
            press: () => pushNewScreenWithRouteSettings<void>(
              context,
              screen: const NotificationScreen(),
              settings:
                  const RouteSettings(name: Routes.notificationScreenRouteName),
              withNavBar: true,
            ),
          ),
        ),
      ],
      flexibleSpace: const FlexibleSpaceBar(
        background: HomeScreenSpecialEventCarouselSlider(),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FirebaseAuth>('auth', auth));
  }
}
