import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_number_constants.dart';
import '../../../shared_features/report/report_screen.dart';

class PostDetailsPopupDialog extends StatelessWidget {
  const PostDetailsPopupDialog({
    Key? key,
    required this.parentContext,
    required this.objectId,
  }) : super(key: key);

  final String objectId;
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
                        Navigator.of(parentContext)
                            .popUntil(ModalRoute.withName('/'));
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
                              LineIcons.values['home'],
                              color: AppColors.kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Quay lại trang chủ'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pushNewScreen<void>(
                          parentContext,
                          screen: ReportScreen(
                            objectId: objectId,
                          ),
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
                            const Text('Báo cáo bài đăng'),
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
    properties.add(StringProperty('objectId', objectId));
  }
}
