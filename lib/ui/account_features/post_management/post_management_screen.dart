import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_dimens.dart';
import '../../../models/ui/chat/temp_class.dart';
import 'tabs/trading_products_tab.dart';

class PostManagementScreen extends StatelessWidget {
  const PostManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabData = [
      'ĐANG TRAO ĐỔI',
      'HẾT HẠN/ẨN',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí bài đăng'),
      ),
      body: DefaultTabController(
        length: tabData.length,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
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
      TradingProductsTab(userDetail: userDetailTemp),
      TradingProductsTab(userDetail: userDetailTemp),
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
