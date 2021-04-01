import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/screens/notification/notification.dart';
import 'package:we_trade/widgets/bottom_navigation_bar.dart';

class DetailedNotificationScreen extends StatelessWidget {

  const DetailedNotificationScreen({
    Key? key,
    this.note = const NotificationData(title: 'Đơn hàng đang trong quá trình vận chuyển', content: 'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển')

  }) : super(key: key);

  static String routeName = '/detailed_notification';

  final NotificationData note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('We Trade'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
      ),
      bottomNavigationBar: const BuildBottomNavigationBar(selectedIndex: 0,),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<NotificationData>('note', note));
  }
}
