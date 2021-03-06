import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_number_constants.dart';
import '../../../../utils/routes/routes.dart';

import '../../../shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../../shared_features/report/report_screen.dart';

class PersonalChatDialog extends StatelessWidget {
  const PersonalChatDialog({
    Key? key,
    required this.parentContext,
    required this.userId,
  }) : super(key: key);

  final String userId;
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
                        pushNewScreenWithRouteSettings<void>(
                          parentContext,
                          settings: const RouteSettings(
                            name: Routes.otherProfileScreenRouteName,
                            // arguments:
                            //     OtherUserProfileArguments(userId: userId)
                          ),
                          screen: OtherUserProfileScreen(
                            userId: userId,
                          ),
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
                            bottom: AppNumberConstants.kBorderSide(),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['userCircleAlt'],
                              color: AppColors.kTextLightColor,
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
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: AppNumberConstants.kBorderSide(),
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
                            bottom: AppNumberConstants.kBorderSide(),
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
                            const Text('Chặn người dùng'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pushNewScreen<void>(
                          parentContext,
                          screen: const ReportScreen(objectId: '',),
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
    properties
        .add(DiagnosticsProperty<BuildContext>('parentContext', parentContext));
    properties.add(StringProperty('userId', userId));
  }
}
