import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../home/local_widgets/home_header.dart';
import 'detailed_notification_screen.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';
import 'notification.dart';

class NotificationScreen extends StatelessWidget {

  NotificationScreen({Key? key}):super(key:key);
  static String routeName='/notificationScreen';

  final List<NotificationData> notes=[const NotificationData(title: 'Đơn hàng đang trong quá trình vận chuyển', content: 'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển'),
    const NotificationData(title: 'Đơn hàng đang trong quá trình vận chuyển', content: 'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển')];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 20),
        child: const HomeHeader(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Thông Báo',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              Column(
                children: notes.map((note)=>NotificationCard(note: note)).toList(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
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
    required this.note
  }):super(key: key);
  final NotificationData note;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextButton(
          onPressed: ()=>Navigator.pushNamed(context, DetailedNotificationScreen.routeName),
          child: Text(
            note.title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
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