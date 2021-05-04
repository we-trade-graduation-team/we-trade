import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class NotificationAppBar extends StatelessWidget {
  const NotificationAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Table(children: <TableRow>[
      TableRow(children: <Widget>[
        SizedBox(
          height: size.height * 0.05,
        )
      ]),
      TableRow(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  LineIcons.angleLeft,
                  color: Colors.grey,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
