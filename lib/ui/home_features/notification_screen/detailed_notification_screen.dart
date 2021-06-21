import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../shared_features/report/local_widgets/pop_header.dart';
import 'notification.dart';

class DetailedNotificationScreen extends StatelessWidget {
  const DetailedNotificationScreen({
    Key? key,
    required this.note,
  }) : super(key: key);
  final NotificationData note;

  @override
  Widget build(BuildContext context) {
    /*const note = NotificationData(
      title: 'Đơn hàng đang trong quá trình vận chuyển',
      content:
          'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển',
      seen: true,
    );*/
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
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<NotificationData>('note', note));
  }
}
