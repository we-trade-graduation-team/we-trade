import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'tabs/wish_tab.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/wish_list';
//  final UserDetail userDetail = userDetailTemp;

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final tabData = [
    'ĐÃ THÍCH',
    'CÓ THỂ THÍCH',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lƯỢT THÍCH'),
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
      const WishTab(),
      const WishTab(),
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
      decoration: BoxDecoration(
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