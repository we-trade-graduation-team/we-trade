import 'package:flutter/material.dart';

import '../../configs/constants/color.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';
import '../follow/follow_screen.dart';
import '../myrate/my_rate_screen.dart';
import '../post_management/post_management_screen.dart';
import '../trading_history/trading_history_screen.dart';
import '../userinfo/userinfo_screen.dart';
import '../wishlist/wishlist_screen.dart';

enum Follow_Screen {
  // ignore: constant_identifier_names
  Following,
  // ignore: constant_identifier_names
  Follower,
}

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  // ignore: sort_constructors_first
  const AccountScreen({
    Key? key,
  }) : super(key: key);

  Widget profileNavigationLabel(
      Widget topWid, Widget botWid, Function navigateToScreen) {
    return GestureDetector(
      onTap: () => navigateToScreen(),
      // ignore: sort_child_properties_last
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
                                onPressed: () {
                                  // ignore: avoid_print
                                  print('setting pressed');
                                })
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
                                      Navigator.of(context)
                                          .pushNamed(UserInfoScreen.routeName);
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
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: <Widget>[
                                    const Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.yellow,
                                    ),
                                    const Text(
                                      '3',
                                    )
                                  ],
                                ),
                                const Text('Leggit'),
                                () {
                                  Navigator.of(context)
                                      .pushNamed(MyRateScreen.routeName);
                                },
                              ),
                              profileNavigationLabel(
                                const Text('0'),
                                const Text('Theo dõi'),
                                () {
                                  // print('theo doi click');
                                  Navigator.of(context).pushNamed(
                                    FollowScreen.routeName,
                                    arguments: Follow_Screen.Following,
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
                                  Navigator.of(context).pushNamed(
                                    FollowScreen.routeName,
                                    arguments: Follow_Screen.Follower,
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
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  buildListTile(
                    const Icon(
                      Icons.post_add,
                      color: Colors.blueGrey,
                    ),
                    'Quản lí bài đăng',
                    () {
                      Navigator.of(context)
                          .pushNamed(PostManagementScreen.routeName);
                    },
                  ),
                  buildListTile(
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                    'Đã thích',
                    () {
                      Navigator.of(context).pushNamed(WishListScreen.routeName);
                    },
                  ),
                  buildListTile(
                    const Icon(
                      Icons.schedule,
                      color: Colors.blue,
                    ),
                    'Lịch sử giao dịch',
                    () {
                      Navigator.of(context)
                          .pushNamed(TradingHistoryScreen.routeName);
                    },
                  ),
                  buildListTile(
                    const Icon(
                      Icons.star_border,
                      color: Colors.green,
                    ),
                    'Đánh giá của tôi',
                    () {
                      Navigator.of(context).pushNamed(MyRateScreen.routeName);
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
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
