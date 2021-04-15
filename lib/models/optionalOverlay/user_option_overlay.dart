import 'package:flutter/material.dart';

class UserOpTionOverlay extends StatelessWidget {
  const UserOpTionOverlay({Key? key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Table(
          defaultColumnWidth: IntrinsicColumnWidth(),
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          // ignore: prefer_const_literals_to_create_immutables
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home_outlined),
                      Text('Quay lại trang chủ'),
                    ],
                  ),
                )
              ]
            ),
            TableRow(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){},
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.block),
                      const Text('Chặn người dùng'),
                    ],
                  ),
                )
              ]
            ),
            TableRow(
                children: <Widget>[
                  RaisedButton(
                    onPressed: (){},
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.report_gmailerrorred_rounded),
                        const Text('Báo cáo người dùng'),
                      ],
                    ),
                  )
                ]
            )
          ],
        ),
      ),
    );
  }
}
