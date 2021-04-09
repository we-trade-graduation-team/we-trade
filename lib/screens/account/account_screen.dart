import 'package:flutter/material.dart';
import 'package:we_trade/screens/follow/follow_screen.dart';

import '../../configs/constants/color.dart';

enum Follow_Screen {
  Following,
  Follower,
}

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

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
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Account'),
      // ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: kPrimaryColor,
              height: 200,
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
                                  print('setting pressed');
                                })
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 60,
                              width: 60,
                              child: CircleAvatar(
                                child: Image.asset(
                                  'assets/images/Chat_screen_ava_temp/user.png',
                                  height: 200,
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
                                      print('thing tin ca nhan tapped');
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
                                () {},
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
            Container(
              height: 450,
              child: ListView(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  buildListTile(
                    const Icon(
                      Icons.post_add,
                      color: Colors.blueGrey,
                    ),
                    'Quản lí bài đăng',
                    () {},
                  ),
                  buildListTile(
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                    'Đã thích',
                    () {},
                  ),
                  buildListTile(
                    const Icon(
                      Icons.schedule,
                      color: Colors.blue,
                    ),
                    'Lịch sử giao dịch',
                    () {
                      print('lich su giao dich');
                    },
                  ),
                  buildListTile(
                    const Icon(
                      Icons.star_border,
                      color: Colors.green,
                    ),
                    'Đánh giá của tôi',
                    () {},
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
