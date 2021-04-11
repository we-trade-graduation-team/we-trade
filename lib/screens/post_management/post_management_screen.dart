import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:we_trade/configs/constants/color.dart';
import 'package:we_trade/models/chat/temp_class.dart';
import 'package:we_trade/screens/post_management/tabs/trading_products_tab.dart';

class PostManagementScreen extends StatefulWidget {
  static const routeName = '/postmanagement';
  final UserDetail userDetail = userDetailTemp;

  @override
  _PostManagementScreenState createState() => _PostManagementScreenState();
}

class _PostManagementScreenState extends State<PostManagementScreen> {
  final tabData = [
    'ĐANG TRAO ĐỔI',
    'HẾT HẠN/ẨN',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí bài đăng'),
      ),
      body: DefaultTabController(
        length: tabData.length,
        child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
               
                SliverPersistentHeader(
                  delegate: MyDelegate(
                    TabBar(
                      tabs: [
                        ...tabData.map(
                          (item) => Tab(
                            child: Text(item),
                          ),
                        ),
                      ],
                    ),
                  ),
                      floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(
              children: getTabContent(),
            )),
      ),
    );
  }

  List<Widget> getTabContent() {
    return [
      TradingProductsTab(userDetail: widget.userDetail),
      TradingProductsTab(userDetail: widget.userDetail),
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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: kTextLightV2Color,
            width: 0.2,
          ),
          bottom: BorderSide(
            color: kTextLightV2Color,
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

class MainInfo extends StatelessWidget {
  const MainInfo({Key? key, required this.width, required this.widget})
      : super(key: key);

  final double width;
  final PostManagementScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
