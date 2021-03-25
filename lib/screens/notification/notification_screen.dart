import 'package:flutter/material.dart';
import 'package:we_trade/screens/notification/notification.dart';

class NotificationScreen extends StatelessWidget {
  List<NotificationData> notes=[const NotificationData(title: 'Đơn hàng đang trong quá trình vận chuyển', content: 'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển'),
    NotificationData(title: 'Đơn hàng đang trong quá trình vận chuyển', content: 'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển')];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Thông Báo',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold
            ),
          ),
          Column(
            children: notes.map((note)=>NotificationCard(note: note)).toList(),
          )
        ],
      ),
    );
  }
}
class NotificationCard extends StatelessWidget {
  final NotificationData note;
  const NotificationCard({required this.note});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          note.title,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}