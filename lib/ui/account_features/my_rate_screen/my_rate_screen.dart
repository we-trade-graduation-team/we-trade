import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants/app_dimens.dart';
import '../../../models/ui/chat/temp_class.dart';
import 'tabs/rate_tab.dart';

class MyRateScreen extends StatelessWidget {
  const MyRateScreen({
    Key? key,
    // required this.userDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabData = [
      'ĐÁNH GIÁ',
      'ĐƯỢC ĐÁNH GIÁ',
    ];

    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá của tôi'),
      ),
      body: DefaultTabController(
        length: tabData.length,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: height * 0.25,
                expandedHeight: height * 0.25,
                flexibleSpace: const MainInfo(),
                automaticallyImplyLeading: false,
              ),
              SliverPersistentHeader(
                delegate: MyDelegate(
                  TabBar(
                    tabs: tabData
                        .map(
                          (item) => Tab(
                            child: Text(item),
                          ),
                        )
                        .toList(),
                  ),
                ),
                floating: true,
                pinned: true,
              )
            ];
          },
          body: TabBarView(
            children: getTabContent(),
          ),
        ),
      ),
    );
  }

  List<Widget> getTabContent() {
    return [
      RateTab(userDetail: userDetailTemp),
      RateTab(userDetail: userDetailTemp),
    ];
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: AppDimens.kBorderSide(),
          bottom: AppDimens.kBorderSide(),
        ),
      ),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class MainInfo extends StatelessWidget {
  const MainInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        child: Image.asset(
                          'assets/images/chat_screen_ava/user.png',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 3.5,
                  allowHalfRating: true,
                  //itemCount: 5,
                  glowRadius: 10,
                  glowColor: Colors.yellow[100],
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  //onRatingUpdate: print,
                  ignoreGestures: true,
                  onRatingUpdate: (_) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
