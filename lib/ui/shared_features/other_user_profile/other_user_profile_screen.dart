import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_dimens.dart';
import '../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../models/ui/chat/temp_class.dart';
import '../../../widgets/custom_material_button.dart';
import '../../../widgets/custom_user_avatar.dart';
import '../../message_features/helper/helper_navigate_chat_room.dart';
import 'dialogs/other_user_profile_dialog.dart';
import 'tabs/about_tab.dart';
import 'tabs/posts_tab.dart';
import 'tabs/review_tab.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;
  @override
  _OtherUserProfileScreenState createState() => _OtherUserProfileScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userId', userId));
  }
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  final tabData = ['ABOUT', 'POSTS', 'REVIEW'];
  final mainInfoKey = GlobalKey();
  Size flexibleSpaceBarSize = const Size(0, 0);
  bool visible = true;

  void navigateToChatRoom(String userid) {
    final thisUser = Provider.of<User?>(context, listen: false)!;
    HelperNavigateChatRoom.checkAndSendChatRoomOneUserByIds(
        userId: userid, thisUser: thisUser, context: context);
  }

  Future<void> getSizeAndPosition() async {
    final cardBox = mainInfoKey.currentContext!.findRenderObject() as RenderBox;
    flexibleSpaceBarSize = cardBox.size;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => getSizeAndPosition().whenComplete(
        () => {
          Future<void>.delayed(const Duration(microseconds: 1)).then(
            (value) {
              setState(() {
                visible = false;
              });
            },
          ),
        },
      ),
    );
  }

  Widget getHeight(double width) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        key: mainInfoKey,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: width / 7,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CircleAvatar(
                    radius: width / 7 - 2.5,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: width / 7 - 5,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      'hi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: const Text('hi\nhi',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
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
                        fontSize: 10,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ReviewProperty(
              press: () {},
              tittle: 'Legit',
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
    //TODO, get userDetail by agrs.id
    final userDetail = userDetailTemp;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(builder: (builderContext) {
            return IconButton(
              icon: Icon(LineIcons.values['verticalEllipsis']),
              onPressed: () {
                showOverlay(context: builderContext);
              },
            );
          })
        ],
        title: const Text('PROFILE NGƯỜI DÙNG'),
      ),
      body: Column(
        children: [
          getHeight(width),
          if (!visible)
            Expanded(
              child: DefaultTabController(
                length: tabData.length,
                child: NestedScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  headerSliverBuilder: (context, isScrolled) {
                    return [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        collapsedHeight: flexibleSpaceBarSize.height,
                        expandedHeight: flexibleSpaceBarSize.height,
                        flexibleSpace: buildMainInfoWidget(userDetail, width),
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
                    //children: getTabContent(),
                    children: [
                      AboutTab(userDetail: userDetail),
                      PostsTab(userDetail: userDetail),
                      ReviewTab(userDetail: userDetail),
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
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CircleAvatar(
                    radius: width / 7 - 2.5,
                    backgroundColor: Colors.white,
                    child: CustomUserAvatar(
                        image: userDetail.user.image, radius: width / 7 - 5),
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
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(userDetail.userDescription,
                          style: const TextStyle(
                            fontSize: 14,
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
                                fontSize: 10,
                                height: 25)),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: CustomMaterialButton(
                              icon: const Icon(
                                Icons.textsms_outlined,
                                // color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                              press: () {
                                //TODO trang navigate to chat_room_screen (id)
                                navigateToChatRoom(widget.userId);
                              },
                              text: 'Nhắn tin',
                              width: MediaQuery.of(context).size.width / 3.8,
                              isFilled: false,
                              fontSize: 10,
                              height: 25),
                        ),
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
                tittle: 'Legit',
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      color: Colors.yellow,
                    ),
                    Text(
                      userDetail.legit.toString(),
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
        'flexibleSpaceBarSize', flexibleSpaceBarSize));
    properties.add(DiagnosticsProperty<bool>('visible', visible));
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
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

class ReviewProperty extends StatelessWidget {
  const ReviewProperty({
    Key? key,
    required this.tittle,
    required this.content,
    required this.press,
  }) : super(key: key);

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

// class OtherUserProfileArguments {
//   OtherUserProfileArguments({required this.userId});
//   final String userId;
// }
