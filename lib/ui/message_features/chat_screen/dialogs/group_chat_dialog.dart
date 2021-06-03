import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_dimens.dart';
import '../../../../models/cloud_firestore/user/user.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../../../utils/routes/routes.dart';
import '../../../shared_features/report/report_screen.dart';
import '../group_chat/members/all_members_screen.dart';
import '../widgets/users_card.dart';

class GroupChatDialog extends StatelessWidget {
  const GroupChatDialog({
    Key? key,
    required this.parentContext,
    required this.chatRoomId,
  }) : super(key: key);
  final BuildContext parentContext;
  final String chatRoomId;

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
                        pushNewScreenWithRouteSettings<void>(
                          parentContext,
                          settings: const RouteSettings(
                            name: Routes.allMemberScreenRouteName,
                          ),
                          screen: AllMemberScreen(chatRoomId: chatRoomId),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: AppDimens.kBorderSide(),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['users'],
                              color: AppColors.kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Thành viên nhóm'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showAlertDialogOutGroup(
                            parentContext, chatRoomId, parentContext);
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: AppDimens.kBorderSide(),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['alternateSignOut'],
                              color: AppColors.kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Rời khỏi nhóm'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: AppDimens.kBorderSide(),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['alternateTrashAlt'],
                              color: AppColors.kTextLightColor,
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
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: AppDimens.kBorderSide(),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['ban'],
                              color: AppColors.kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Chặn nhóm'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pushNewScreen<void>(
                          parentContext,
                          screen: const ReportScreen(),
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
                              color: AppColors.kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Báo cáo nhóm'),
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
    properties
        .add(DiagnosticsProperty<BuildContext>('parentContext', parentContext));
    properties.add(StringProperty('ChatRoomId', chatRoomId));
  }
}

Future<Widget?> showAlertDialogOutGroup(
    BuildContext context, String chatRoomId, BuildContext parentContext) {
  final Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text('Hủy'),
  );
  final Widget continueButton = TextButton(
    onPressed: () async {
      Navigator.of(context).pop();
      UsersCard.showBottomSheet(context);
      await Future.delayed(const Duration(milliseconds: 1000), () async {});
      final thisUser = Provider.of<User?>(context, listen: false)!;
      final messageServiceFireStore = MessageServiceFireStore();
      await messageServiceFireStore.outOfChatRoom(chatRoomId, thisUser.uid!);
      Navigator.of(parentContext).popUntil(ModalRoute.withName('/'));
    },
    child: const Text('Rời khỏi'),
  );

  final alert = AlertDialog(
    title: const Text('Rời khỏi nhóm ?'),
    content: const Text(
        'Bạn có chắc chắn muốn rời khỏi cuộc trò chuyện? \n bạn sẽ không nhận được tin nhắn mới nữa'),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  return showDialog<Widget>(
    context: context,
    builder: (context) {
      return alert;
    },
  );
}
