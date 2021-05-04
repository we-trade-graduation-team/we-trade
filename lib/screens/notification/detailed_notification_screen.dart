import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../report/local_widgets/pop_header.dart';
import 'notification.dart';

class DetailedNotificationScreen extends StatelessWidget {

  const DetailedNotificationScreen({Key? key}):super(key: key);
  static String routeName='/detailedNotificationScreen';
  // ignore: avoid_field_initializers_in_const_classes
  final NotificationData note = const NotificationData(title: 'Đơn hàng đang trong quá trình vận chuyển', content: 'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển',seen: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height + 20),
          child: const PopHeader(),
        ),
      body: Padding(
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
      ),
      //bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<NotificationData>('note', note));
  }
}
