import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'notification.dart';

class DetailedNotificationScreen extends StatelessWidget {

  const DetailedNotificationScreen({Key? key}):super(key: key);
  static String routeName='/detailedNotificationScreen';
  // ignore: avoid_field_initializers_in_const_classes
  final NotificationData note = const NotificationData(title: 'Đơn hàng đang trong quá trình vận chuyển', content: 'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            note.title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              note.content,
              style: const TextStyle(
                  fontSize: 18
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<NotificationData>('note', note));
  }
}
