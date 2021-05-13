import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/assets_paths/shared_assets_root.dart';
import '../../../configs/constants/color.dart';
import '../../wish_list_features/wish_list/wish_list_screen.dart';
import '../account_settings_screen/account_settings_screen.dart';
import '../follow/follow_screen.dart';
import '../my_rate/my_rate_screen.dart';
import '../post_management/post_management_screen.dart';
import '../trading_history/trading_history_screen.dart';
import '../user_info/user_info_screen.dart';

class AccountListTileModel {
  AccountListTileModel({
    required this.leadingIcon,
    required this.titleText,
    required this.onTapFunc,
  });

  final Icon leadingIcon;
  final String titleText;
  final VoidCallback onTapFunc;
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/account';

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

  ListTile buildListTile(AccountListTileModel model) {
    return ListTile(
      leading: model.leadingIcon,
      title: Text(model.titleText),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: model.onTapFunc,
      minLeadingWidth: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bannerHeight = height * 0.28;

    final accountListTileItemModel = [
      AccountListTileModel(
        titleText: 'Quản lí bài đăng',
        leadingIcon: const Icon(
          Icons.post_add,
          color: Colors.blueGrey,
        ),
        onTapFunc: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: PostManagementScreen.routeName,
            ),
            screen: PostManagementScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Đã thích',
        leadingIcon: const Icon(
          Icons.favorite_border,
          color: Colors.redAccent,
        ),
        onTapFunc: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: WishListScreen.routeName,
            ),
            screen: const WishListScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Lịch sử giao dịch',
        leadingIcon: const Icon(
          Icons.schedule,
          color: Colors.blue,
        ),
        onTapFunc: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: TradingHistoryScreen.routeName,
            ),
            screen: TradingHistoryScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Đánh giá của tôi',
        leadingIcon: const Icon(
          Icons.star_border,
          color: Colors.green,
        ),
        onTapFunc: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: MyRateScreen.routeName,
            ),
            screen: MyRateScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Thiết lập tài khoản',
        leadingIcon: const Icon(
          Icons.person_outline,
          color: Colors.lightBlue,
        ),
        onTapFunc: () {
          pushNewScreen<void>(
            context,
            screen: const AccountSettingsScreen(),
            withNavBar: false,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Trợ giúp',
        leadingIcon: const Icon(
          Icons.help_outline,
          color: Colors.amber,
        ),
        onTapFunc: () {},
      ),
    ];

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
                                onPressed: () {}),
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
                                const Text(
                                  'Duy quang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: kPrimaryLightColor,
                                  ),
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: accountListTileItemModel.length,
              itemBuilder: (_, index) => buildListTile(
                accountListTileItemModel[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
