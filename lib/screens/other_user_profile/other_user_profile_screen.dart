import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../post_items/step1.dart';
import '../post_items/step2.dart';

import 'package:line_icons/line_icons.dart';


// ignore: directives_ordering
import '../../configs/constants/color.dart';
import '../../models/chat/temp_class.dart';
import '../../widgets/custom_material_button.dart';
import '../chat/personal_chat/personal_chat_screen.dart';
import 'dialogs/other_user_profile_dialog.dart';
import 'tabs/about_tab.dart';
import 'tabs/posts_tab.dart';
import 'tabs/review_tab.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({Key? key}) : super(key: key);

  static String routeName = '/other_user_profile';

  @override
  _OtherUserProfileScreenState createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  final tabData = ['ABOUT', 'POSTS', 'REVIEW'];
  final mainInfoKey = GlobalKey();
  late Size sizeFlexibleSpaceBar;
  bool _visible = true;

  Future<void> getSizeAndPosition() async {
    final _cardBox =
        mainInfoKey.currentContext!.findRenderObject() as RenderBox;
    sizeFlexibleSpaceBar = _cardBox.size;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => getSizeAndPosition().whenComplete(() => {
              Future<void>.delayed(const Duration(microseconds: 1))
                  .then((value) {
                setState(() {
                  _visible = false;
                });
              })
            }));
  }

  Widget getHeight(double width) {
    return Visibility(
      visible: _visible,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        key: mainInfoKey,
        child: Column(
          children: [
            CircleAvatar(
              radius: width / 7,
              backgroundColor: kPrimaryColor,
              child: CircleAvatar(
                radius: width / 7 - 2.5,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: width / 7 - 5,
                ),
              ),
            ),
            ReviewProperty(
              press: () {},
              tittle: 'Leggit',
              content: const Text(
                '..',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final agrs =
        ModalRoute.of(context)!.settings.arguments as OtherUserProfileArguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.more_vert),
          //   onPressed: () {
          //     showOverlay(context: context);
          //   },
          // ),
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(LineIcons.values['verticalEllipsis']),
              onPressed: () {
                showOverlay(context: context);
              },
            );
          })
        ],
        title: const Text('PROFILE NGƯỜI DÙNG'),
      ),
      body: Column(
        children: [
          getHeight(width),
          if (!_visible)
            Expanded(
              child: DefaultTabController(
                length: tabData.length,
                child: NestedScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  headerSliverBuilder: (context, isScolled) {
                    return [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        collapsedHeight: sizeFlexibleSpaceBar.height,
                        expandedHeight: sizeFlexibleSpaceBar.height,
                        flexibleSpace:
                            buildMainInfoWidget(agrs.userDetail, width),
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
                    //children: getTabContent(),
                    children: [
                      AboutTab(userDetail: agrs.userDetail),
                      PostsTab(userDetail: agrs.userDetail),
                      ReviewTab(userDetail: agrs.userDetail),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildMainInfoWidget(
    UserDetail userDetail,
    double width,
  ) {
    return Padding(
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
                      backgroundImage: AssetImage(userDetail.user.image),
                      radius: width / 7 - 5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userDetail.user.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kTextLightV2Color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(userDetail.userDesciption,
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
                            child: CustomMaterialButton(
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
                            child: CustomMaterialButton(
                                icon: const Icon(
                                  Icons.textsms_outlined,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                                press: () => Navigator.pushNamed(
                                    context, PersonalChatScreen.routeName,
                                    arguments: PersonalChatArguments(
                                        chat: Chat(
                                      id: 0,
                                      lastMessage: '',
                                      time: '',
                                      users: [userDetail.user],
                                    ))),
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
                      userDetail.leggit.toString(),
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
                  userDetail.postsNum.toString(),
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
                  userDetail.followers.toString(),
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

  void showOverlay({required BuildContext context}) {
    BotToast.showAttachedWidget(
      attachedBuilder: (_) => OtherUserProfileDialog(parentContext: context),
      targetContext: context,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('tabData', tabData));
    properties.add(DiagnosticsProperty<GlobalKey<State<StatefulWidget>>>(
        'mainInfoKey', mainInfoKey));
    properties.add(DiagnosticsProperty<Size>(
        'sizeFlexibleSpaceBar', sizeFlexibleSpaceBar));
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

class OtherUserProfileArguments {
  OtherUserProfileArguments({required this.userDetail});
  UserDetail userDetail;
}
