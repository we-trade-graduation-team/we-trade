import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../models/ui/chat/temp_class.dart';
import '../account_screen/account_screen.dart';

import 'tabs/rate_tab.dart';

class MyRateScreen extends StatefulWidget {
  MyRateScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/myrate';
  final UserDetail userDetail = userDetailTemp;
  final referenceDatabase = AccountScreen.localRefDatabase;
  final userID = AccountScreen.localUserID;

  @override
  _MyRateScreenState createState() => _MyRateScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
    properties.add(DiagnosticsProperty<DocumentReference<Map<String, dynamic>>>(
        'referenceDatabase', referenceDatabase));
    properties.add(StringProperty('userID', userID));
  }
}

class _MyRateScreenState extends State<MyRateScreen> {
  final tabData = [
    'TÔI ĐÁNH GIÁ',
    'ĐƯỢC ĐÁNH GIÁ',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá của tôi'),
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
            )),
      ),
    );
  }

  List<Widget> getTabContent() {
    return [
      // RateTab(isMyRateFromOther: false, userDetail: widget.userDetail),
      // RateTab(isMyRateFromOther: true, userDetail: widget.userDetail),
      const RateTab(isMyRateFromOther: false),
      const RateTab(isMyRateFromOther: true),
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

class MainInfo extends StatefulWidget {
  const MainInfo({Key? key, required this.width, required this.widget})
      : super(key: key);

  final double width;
  final MyRateScreen widget;

  @override
  _MainInfoState createState() => _MainInfoState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', width));
  }
}

class _MainInfoState extends State<MainInfo> {
  final referenceDatabase = AccountScreen.localRefDatabase;
  final userID = AccountScreen.localUserID;

  double legit = 0;
  String avatarUrl = '';

  @override
  void initState() {
    super.initState();
    try {
      referenceDatabase
          .collection('users')
          .doc(userID)
          .get()
          .then((documentSnapshot) {
        final _user = documentSnapshot.data();
        if (_user == null) {
          legit = 0;
        } else {
          setState(() {
            legit = double.parse(_user['legit'].toString());
            legit = legit > 5 ? 5 : legit;
            legit = legit < 0 ? 0 : legit;
            avatarUrl = _user['avatarUrl'].toString();
          });
        }
      });
    } on FirebaseException catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    const avatarSize = 110.0;
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
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(avatarSize / 2),
                      ),
                      height: avatarSize,
                      width: avatarSize,
                      child: ClipOval(
                        child: avatarUrl.isNotEmpty
                            ? Image.network(
                                avatarUrl,
                                fit: BoxFit.cover,
                                height: 110,
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: legit,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', widget.width));
    properties.add(DoubleProperty('legit', legit));
    properties.add(DiagnosticsProperty<DocumentReference<Map<String, dynamic>>>(
        'referenceDatabase', referenceDatabase));
    properties.add(StringProperty('userID', userID));
    properties.add(StringProperty('avatarUrl', avatarUrl));
  }
}
