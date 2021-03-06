import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../constants/app_colors.dart';
import '../../../utils/routes/routes.dart';
import '../../wish_list_features/wish_list/wish_list_screen.dart';
import '../account_settings_screen/account_settings_screen.dart';
import '../follow_screen/follow_screen.dart';
import '../my_rate_screen/my_rate_screen.dart';
import '../post_management/post_management_screen.dart';
import '../trading_history/trading_history_screen.dart';
import '../user_info/user_info_screen.dart';
import 'local_widgets/getter.dart';
import 'local_widgets/pickers/user_image_picker.dart';

class AccountListTileModel {
  AccountListTileModel({
    required this.leadingIcon,
    required this.titleText,
    required this.onTapFunc,
  });

  final Icon leadingIcon;
  final String titleText;
  final VoidCallback onTapFunc;
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _userID = FirebaseAuth.instance.currentUser!.uid;
  final referenceDatabase = FirebaseFirestore.instance;

  Widget profileNavigationLabel(
      Widget topWid, Widget botWid, Function navigateToScreen) {
    return GestureDetector(
      onTap: () => navigateToScreen(),
      child: Column(
        children: [
          topWid,
          botWid,
        ],
      ),
    );
  }

  ListTile buildListTile(AccountListTileModel model) {
    return ListTile(
      leading: model.leadingIcon,
      title: Text(model.titleText),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: model.onTapFunc,
      minLeadingWidth: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bannerHeight = height * 0.28;

    final accountListTileItemModel = [
      AccountListTileModel(
        titleText: 'Quản lí bài đăng',
        leadingIcon: const Icon(
          Icons.post_add,
          color: Colors.blueGrey,
        ),
        onTapFunc: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: Routes.postManagementScreenRouteName,
            ),
            screen: const PostManagementScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Đã thích',
        leadingIcon: const Icon(
          Icons.favorite_border,
          color: Colors.redAccent,
        ),
        onTapFunc: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: Routes.wishListScreenRouteName,
            ),
            screen: const WishListScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Lịch sử giao dịch',
        leadingIcon: const Icon(
          Icons.schedule,
          color: Colors.blue,
        ),
        onTapFunc: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: Routes.tradingHistoryScreenRouteName,
            ),
            screen: const TradingHistoryScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Đánh giá của tôi',
        leadingIcon: const Icon(
          Icons.star_border,
          color: Colors.green,
        ),
        onTapFunc: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(
              name: Routes.myRateScreenRouteName,
            ),
            screen: MyRateScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Thiết lập tài khoản',
        leadingIcon: const Icon(
          Icons.person_outline,
          color: Colors.lightBlue,
        ),
        onTapFunc: () {
          pushNewScreen<void>(
            context,
            screen: const AccountSettingsScreen(),
            withNavBar: false,
          );
        },
      ),
      AccountListTileModel(
        titleText: 'Trợ giúp',
        leadingIcon: const Icon(
          Icons.help_outline,
          color: Colors.amber,
        ),
        onTapFunc: () {},
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              color: Theme.of(context).primaryColor,
              height: bannerHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 55,
                              width: 55,
                              child: UserImagePicker(
                                userID: _userID,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: AppColors.kPrimaryLightColor,
                                  ),
                                  child: GetUserName(
                                    documentId: _userID,
                                    isStream: true,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black87,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      pushNewScreenWithRouteSettings<void>(
                                        context,
                                        settings: const RouteSettings(
                                          name: Routes.userInfoScreenRouteName,
                                        ),
                                        screen: const UserInfoScreen(),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: const Text(
                                      'Thông tin tài khoản',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColors.kPrimaryLightColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.kPrimaryLightColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              profileNavigationLabel(
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.yellow,
                                    ),
                                    GetLegit(documentId: _userID),
                                  ],
                                ),
                                const Text('Legit\n'),
                                () {
                                  pushNewScreenWithRouteSettings<void>(
                                    context,
                                    settings: const RouteSettings(
                                      name: Routes.myRateScreenRouteName,
                                    ),
                                    screen: MyRateScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                              profileNavigationLabel(
                                GetNumberOfFollow(
                                  documentId: _userID,
                                  typeOfReturnNumber:
                                      Follow_Screen_Name.following,
                                ),
                                const Text(
                                  'Đang theo \n  dõi',
                                  textAlign: TextAlign.center,
                                ),
                                () {
                                  pushNewScreenWithRouteSettings<void>(
                                    context,
                                    settings: RouteSettings(
                                      name: Routes.followScreenRouteName,
                                      arguments: {
                                        'screenArgument': FollowScreenArguments(
                                          screenName:
                                              Follow_Screen_Name.following,
                                        ),
                                        'userID': _userID
                                      },
                                    ),
                                    screen: const FollowScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                              profileNavigationLabel(
                                GetNumberOfFollow(
                                  documentId: _userID,
                                  typeOfReturnNumber:
                                      Follow_Screen_Name.follower,
                                ),
                                const Text(
                                  'Người theo \n dõi',
                                  textAlign: TextAlign.center,
                                ),
                                () {
                                  pushNewScreenWithRouteSettings<void>(
                                    context,
                                    settings: RouteSettings(
                                      name: Routes.followScreenRouteName,
                                      arguments: {
                                        'screenArgument': FollowScreenArguments(
                                          screenName:
                                              Follow_Screen_Name.follower,
                                        ),
                                        'userID': _userID
                                      },
                                    ),
                                    screen: const FollowScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: accountListTileItemModel.length,
              itemBuilder: (_, index) => buildListTile(
                accountListTileItemModel[index],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FirebaseFirestore>(
        'referenceDatabase', referenceDatabase));
  }
}
