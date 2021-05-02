import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../post_items/step1.dart';
import '../post_items/step2.dart';

// ignore: directives_ordering
import '../../configs/constants/color.dart';
import '../../models/chat/temp_class.dart';
import '../../widgets/buttons.dart';
import 'tabs/about_tab.dart';
import 'tabs/posts_tab.dart';
import 'tabs/review_tab.dart';

class OtherUserProfileScreen extends StatefulWidget {
  OtherUserProfileScreen({Key? key}) : super(key: key);

  final UserDetail userDetail = userDetailTemp;

  @override
  _OtherUserProfileScreenState createState() => _OtherUserProfileScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
  }
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  final tabData = ['ABOUT', 'POSTS', 'REVIEW'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: const Text('PROFILE NGƯỜI DÙNG'),
      ),
      body: DefaultTabController(
        length: tabData.length,
        child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  collapsedHeight: height * 0.36,
                  expandedHeight: height * 0.36,
                  flexibleSpace: MainInfo(width: width, widget: widget),
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
      AboutTab(userDetail: widget.userDetail),
      PostsTab(userDetail: widget.userDetail),
      ReviewTab(userDetail: widget.userDetail),
    ];
  }

  Widget tabContent(
    String title,
    int length,
  ) {
    return SingleChildScrollView(
      child: Column(
        key: ValueKey<int>(length),
        children: [
          ...List.generate(
            length,
            (index) => ListTile(
              title: Text('$title item $index'),
              trailing: const Icon(Icons.access_alarm),
            ),
          ),
        ],
      ),
    );
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
  final OtherUserProfileScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: CircleAvatar(
                  radius: width / 7,
                  backgroundColor: kPrimaryColor,
                  child: CircleAvatar(
                    radius: width / 7 - 2.5,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.userDetail.user.image),
                      radius: width / 7 - 5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.userDetail.user.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kTextLightV2Color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(widget.userDetail.userDesciption,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kTextLightV2Color,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: ButtonWidget(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                press: () {},
                                text: 'Theo dõi',
                                width: MediaQuery.of(context).size.width / 3.8,
                                fontsize: 10,
                                height: 25)),
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: ButtonWidget(
                                icon: const Icon(
                                  Icons.textsms_outlined,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                                press: () {},
                                text: 'Nhắn tin',
                                width: MediaQuery.of(context).size.width / 3.8,
                                isFilled: false,
                                fontsize: 10,
                                height: 25)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReviewProperty(
                press: () {},
                tittle: 'Leggit',
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      color: Colors.yellow,
                    ),
                    Text(
                      widget.userDetail.leggit.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ReviewProperty(
                press: () {},
                tittle: 'Posts',
                content: Text(
                  widget.userDetail.postsNum.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ReviewProperty(
                press: () {},
                tittle: 'Followers',
                content: Text(
                  widget.userDetail.followers.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', width));
  }
}

class ReviewProperty extends StatelessWidget {
  const ReviewProperty(
      {Key? key,
      required this.tittle,
      required this.content,
      required this.press})
      : super(key: key);

  final String tittle;
  final Widget content;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            content,
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  tittle,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // This trailing comma makes auto-formatting nicer for build methods.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('tittle', tittle));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
  }
}
