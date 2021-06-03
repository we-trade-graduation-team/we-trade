import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../shared_features/report/local_widgets/pop_header.dart';
import 'notification.dart';

class DetailedNotificationScreen extends StatelessWidget {
  const DetailedNotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const note = NotificationData(
      title: 'Đơn hàng đang trong quá trình vận chuyển',
      content:
          'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển',
      seen: true,
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 20),
        child: const PopHeader(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                note.content,
                style: const TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
