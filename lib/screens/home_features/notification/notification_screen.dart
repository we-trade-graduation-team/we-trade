import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../notification/local_widgets/notification_appbar.dart';

import 'detailed_notification_screen.dart';
import 'notification.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  static String routeName = '/notificationScreen';

  final List<NotificationData> notes = [
    const NotificationData(
        title: 'Đơn hàng đang trong quá trình vận chuyển',
        content:
            'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển',
        seen: false),
    const NotificationData(
        title: 'Đơn hàng đang trong quá trình vận chuyển',
        content:
            'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển',
        seen: true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height + 20),
          child: const NotificationAppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thông Báo',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Column(
                children: notes
                    .map((note) => NotificationCard(
                          note: note,
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
      //bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<NotificationData>('notes', notes));
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.note,
  }) : super(key: key);
  final NotificationData note;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.seen ? Colors.grey[400] : Colors.grey[200],
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextButton(
          onPressed: () => pushNewScreenWithRouteSettings<void>(
            context,
            screen: const DetailedNotificationScreen(),
            settings: const RouteSettings(name: '/detailedNotificationScreen'),
            withNavBar: true,
          ),
          child: Text(
            note.title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
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
