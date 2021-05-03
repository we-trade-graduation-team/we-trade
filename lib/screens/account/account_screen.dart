import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../configs/constants/color.dart';
import '../follow/follow_screen.dart';
import '../myrate/my_rate_screen.dart';
import '../post_management/post_management_screen.dart';
import '../trading_history/trading_history_screen.dart';
import '../userinfo/userinfo_screen.dart';
import '../wishlist/wishlist_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    Key? key,
    required this.menuScreenContext,
    required this.onScreenHideButtonPressed,
    required this.hideStatus,
  }) : super(key: key);

  static const routeName = '/account';
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BuildContext>(
        'menuScreenContext', menuScreenContext));
    properties.add(DiagnosticsProperty<Function>(
        'onScreenHideButtonPressed', onScreenHideButtonPressed));
    properties.add(DiagnosticsProperty<bool>('hideStatus', hideStatus));
  }

  Widget profileNavigationLabel(
      Widget topWid, Widget botWid, Function navigateToScreen) {
    return GestureDetector(
      onTap: () => navigateToScreen(),
      child: Column(
        children: <Widget>[
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
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                color: kPrimaryLightColor,
                                icon: const Icon(Icons.settings),
                                onPressed: () {}),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 55,
                              width: 55,
                              child: CircleAvatar(
                                child: Image.asset(
                                  'assets/images/Chat_screen_ava_temp/user.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
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
                                        screen: UserInfoScreen(),
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
                            children: <Widget>[
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
                children: <Widget>[
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
}
