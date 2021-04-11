import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:we_trade/configs/constants/color.dart';
import 'package:we_trade/models/chat/temp_class.dart';
import 'package:we_trade/screens/myrate/tabs/rate_tab.dart';
import 'package:we_trade/screens/other_user_profile/other_user_profile_screen.dart';
import 'package:we_trade/screens/other_user_profile/tabs/review_tab.dart';
import 'package:we_trade/screens/userinfo/userinfo_screen.dart';
import 'package:we_trade/widgets/buttons.dart';

class MyRateScreen extends StatefulWidget {
  static const routeName = '/myrate';
  final UserDetail userDetail = userDetailTemp;

  @override
  _MyRateScreenState createState() => _MyRateScreenState();
}

class _MyRateScreenState extends State<MyRateScreen> {
  // ignore: diagnostic_describe_all_properties
  final tabData = ['ĐÁNH GIÁ', 'ĐƯỢC ĐÁNH GIÁ',];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:const Text('Đánh giá của tôi'),
      ),
      body: DefaultTabController(
        length: tabData.length,
        child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  collapsedHeight: height * 0.25,
                  expandedHeight: height * 0.25,
                  flexibleSpace: MainInfo(width: width, widget: widget),
                  automaticallyImplyLeading: false,
                ),
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
      RateTab(userDetail: widget.userDetail),
      RateTab(userDetail: widget.userDetail),

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
  final MyRateScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        child: Image.asset(
                          'assets/images/Chat_screen_ava_temp/user.png',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
            
                RatingBar.builder(
                    initialRating: 3.8,
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
                    onRatingUpdate: (value) {},
                  ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
