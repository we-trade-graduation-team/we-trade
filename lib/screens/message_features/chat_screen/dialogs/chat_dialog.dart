import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../configs/constants/color.dart';
import '../../../../models/chat/temp_class.dart';
import '../../../shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../../shared_features/report/report_screen.dart';

class ChatDialog extends StatelessWidget {
  const ChatDialog({Key? key, required this.user, required this.parentContext})
      : super(key: key);
  final User user;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(-2, 2), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(2, -2), // changes position of shadow
            ),
          ],
        ),
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        //TODO:  kiếm userdetail dựa theo user được truyền vào
                        final userDetail = userDetailTemp;
                        pushNewScreenWithRouteSettings<void>(
                          parentContext,
                          settings: RouteSettings(
                            name: OtherUserProfileScreen.routeName,
                            arguments: OtherUserProfileArguments(
                              userDetail: userDetail,
                            ),
                          ),
                          screen: const OtherUserProfileScreen(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: kTextColor,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['userCircleAlt'],
                              color: kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Xem hồ sơ'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: kTextColor,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['alternateTrashAlt'],
                              color: kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Xóa cuộc trò chuyện'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: kTextColor,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['ban'],
                              color: kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Chặn người dùng'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pushNewScreen<void>(
                          parentContext,
                          screen: const ReportScreenBloc(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['exclamationCircle'],
                              color: kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Báo cáo người dùng'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User>('user', user));
    properties
        .add(DiagnosticsProperty<BuildContext>('parentContext', parentContext));
  }
}
