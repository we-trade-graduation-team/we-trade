import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../models/ui/chat/temp_class.dart';

import 'tabs/trading_products_tab.dart';

class PostManagementScreen extends StatefulWidget {
  PostManagementScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/postmanagement';
  final UserDetail userDetail = userDetailTemp;

  @override
  _PostManagementScreenState createState() => _PostManagementScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
  }
}

class _PostManagementScreenState extends State<PostManagementScreen> {
  final tabData = [
    'ĐANG TRAO ĐỔI',
    'HẾT HẠN/ẨN',
  ];

  @override
  Widget build(BuildContext context) {
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
      const TradingProductsTab(isHiddenPosts: false),
      const TradingProductsTab(isHiddenPosts: true),
    ];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('tabData', tabData));
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 0.2,
          ),
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 0.2,
          ),
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
