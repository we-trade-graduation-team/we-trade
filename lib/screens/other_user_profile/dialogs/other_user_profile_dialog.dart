import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../configs/constants/color.dart';

class OtherUserProfileDialog extends StatelessWidget {
  const OtherUserProfileDialog({Key? key}) : super(key: key);
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
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: kTextLightV2Color,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.values['home'],
                              color: kTextLightColor,
                              size: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text('Quay lại trang chủ'),
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
                              color: kTextLightV2Color,
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
                      onTap: () {},
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
}