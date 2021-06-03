import 'package:flutter/material.dart';

class UserOptionOverlay extends StatelessWidget {
  const UserOptionOverlay({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            ElevatedButton(
              onPressed: () {},
              child: Row(
                children: const [
                  Icon(Icons.home_outlined),
                  Text('Quay lại trang chủ'),
                ],
              ),
            )
          ]),
          TableRow(children: [
            ElevatedButton(
              onPressed: () {},
              child: Row(
                children: const [
                  Icon(Icons.block),
                  Text('Chặn người dùng'),
                ],
              ),
            )
          ]),
          TableRow(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(Icons.report_gmailerrorred_rounded),
                    Text('Báo cáo người dùng'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
