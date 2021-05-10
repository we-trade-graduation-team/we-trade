import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../configs/constants/assets_paths/shared_assets_root.dart';

import '../../../configs/constants/color.dart';
import '../../wish_list_features/wish_list/wish_list_screen.dart';
import '../follow/follow_screen.dart';
import '../my_rate/my_rate_screen.dart';
import '../post_management/post_management_screen.dart';
import '../trading_history/trading_history_screen.dart';
import '../user_info/user_info_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/account';
  // final quangDocID = 'h0Z8Hn6XvbtMsP4bwa4P';
  static final localRefDatabase = FirebaseFirestore.instance
      .collection('quang')
      .doc('h0Z8Hn6XvbtMsP4bwa4P');
  static const localUserID = 'HClKVm4TTdlx28xCKTxF';

  Widget profileNavigationLabel(
      Widget topWid, Widget botWid, Function navigateToScreen) {
    return GestureDetector(
      onTap: () => navigateToScreen(),
      child: Column(
        children: [
          topWid,
          botWid,
        ],
      ),
    );
  }

  ListTile buildListTile(
      Icon leadingIcon, String titleText, Function onTapFunc) {
    return ListTile(
      leading: leadingIcon,
      title: Align(
        alignment: const Alignment(-1.2, 0),
        child: Text(titleText),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => onTapFunc(),
    );
  }

  // ignore: avoid_field_initializers_in_const_classes
  final user = {
    'name': 'Tranf Duy qunag',
    'email': 'asdas@hail.com',
    'phoneNumber': '0202424024',
    'location': 'asdasaf',
    'bio': 'I like trading',
    'following': <dynamic>[],
    'followers': <dynamic>[],
  };

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return localRefDatabase
        .collection('users')
        .add(user)
        .then((value) => print('User Added: $user'));
    // .catchError((error) => print('Failed to add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bannerHeight = height * 0.28;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Account'),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: kPrimaryColor,
              height: bannerHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              color: kPrimaryLightColor,
                              icon: const Icon(Icons.settings),
                              onPressed: () {
                                // ignore: avoid_print
                                print('setting pressed');
                              },
                            ),
                            IconButton(
                              color: kPrimaryLightColor,
                              icon: const Icon(Icons.add),
                              onPressed: addUser,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 55,
                              width: 55,
                              child: CircleAvatar(
                                child: Image.asset(
                                  '$chatScreenAvaFolder/user.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const GetUserName(
                                  documentId: localUserID,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black87,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      pushNewScreenWithRouteSettings<void>(
                                        context,
                                        settings: const RouteSettings(
                                          name: UserInfoScreen.routeName,
                                        ),
                                        screen: const UserInfoScreen(),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: const Text(
                                      'Thông tin tài khoản',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: kPrimaryLightColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 16,
                            color: kPrimaryLightColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              profileNavigationLabel(
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      '3',
                                    )
                                  ],
                                ),
                                const Text('Leggit'),
                                () {
                                  pushNewScreenWithRouteSettings<void>(
                                    context,
                                    settings: const RouteSettings(
                                      name: MyRateScreen.routeName,
                                    ),
                                    screen: MyRateScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                              profileNavigationLabel(
                                const Text('0'),
                                const Text('Theo dõi'),
                                () {
                                  pushNewScreenWithRouteSettings<void>(
                                    context,
                                    settings: RouteSettings(
                                      name: FollowScreen.routeName,
                                      arguments: FollowScreenArguments(
                                          screenName:
                                              Follow_Screen_Name.following),
                                    ),
                                    screen: const FollowScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                              profileNavigationLabel(
                                const Text('1'),
                                const Text(
                                  'Người theo \n dõi',
                                  textAlign: TextAlign.center,
                                ),
                                () {
                                  pushNewScreenWithRouteSettings<void>(
                                    context,
                                    settings: RouteSettings(
                                      name: FollowScreen.routeName,
                                      arguments: FollowScreenArguments(
                                          screenName:
                                              Follow_Screen_Name.follower),
                                    ),
                                    screen: const FollowScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildListTile(
                    const Icon(
                      Icons.post_add,
                      color: Colors.blueGrey,
                    ),
                    'Quản lí bài đăng',
                    () {
                      pushNewScreenWithRouteSettings<void>(
                        context,
                        settings: const RouteSettings(
                          name: PostManagementScreen.routeName,
                        ),
                        screen: PostManagementScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                  buildListTile(
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                    'Đã thích',
                    () {
                      pushNewScreenWithRouteSettings<void>(
                        context,
                        settings: const RouteSettings(
                          name: WishListScreen.routeName,
                        ),
                        screen: const WishListScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                  buildListTile(
                    const Icon(
                      Icons.schedule,
                      color: Colors.blue,
                    ),
                    'Lịch sử giao dịch',
                    () {
                      pushNewScreenWithRouteSettings<void>(
                        context,
                        settings: const RouteSettings(
                          name: TradingHistoryScreen.routeName,
                        ),
                        screen: TradingHistoryScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                  buildListTile(
                    const Icon(
                      Icons.star_border,
                      color: Colors.green,
                    ),
                    'Đánh giá của tôi',
                    () {
                      pushNewScreenWithRouteSettings<void>(
                        context,
                        settings: const RouteSettings(
                          name: MyRateScreen.routeName,
                        ),
                        screen: MyRateScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                  buildListTile(
                    const Icon(
                      Icons.person_outline,
                      color: Colors.lightBlue,
                    ),
                    'Thiết lập tài khoản',
                    () {},
                  ),
                  buildListTile(
                    const Icon(
                      Icons.help_outline,
                      color: Colors.amber,
                    ),
                    'Trợ giúp',
                    () {},
                  ),
                ],
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
    properties.add(DiagnosticsProperty<DocumentReference<Map<String, dynamic>>>(
        'localRefDatabase', localRefDatabase));
    properties.add(DiagnosticsProperty<Map<String, Object>>('user', user));
  }
}

class GetUserName extends StatelessWidget {
  const GetUserName({Key? key, required this.documentId}) : super(key: key);
  final String documentId;

  @override
  Widget build(BuildContext context) {
    final CollectionReference users =
        AccountScreen.localRefDatabase.collection('users');

    return StreamBuilder<DocumentSnapshot>(
      stream: users.doc(documentId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: Colors.red.withOpacity(0.5),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            'Loading',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: kPrimaryLightColor.withOpacity(0.5),
            ),
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text(
            'Document does not exist',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: kPrimaryLightColor,
            ),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final name = data['name'].toString();
        return Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kPrimaryLightColor,
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('documentId', documentId));
  }
}
