import 'package:flutter/material.dart';
import 'package:we_trade/screens/notification/notification.dart';

class DetailedNotificationScreen extends StatelessWidget {
  NotificationData note =NotificationData(title: 'Đơn hàng đang trong quá trình vận chuyển', content: 'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            note.title,
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              note.content,
              style: TextStyle(
                  fontSize: 18.0
              ),
            ),
          )
        ],
      ),
    );
  }
}
