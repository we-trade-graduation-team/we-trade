import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/strings.dart';
import 'notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen(
      {Key? key,
      this.notes = const [
        NotificationData(
            title: 'Đơn hàng đang trong quá trình vận chuyển',
            content:
                'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển'),
        NotificationData(
            title: 'Đơn hàng đang trong quá trình vận chuyển',
            content:
                'Đơn hàng của quí khách đã được tiếp nhận bởi bộ phận vận chuyển')
      ]})
      : super(key: key);

  static String routeName = '/notification';

  final List<NotificationData> notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
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
                    .map(
                      (note) => NotificationCard(note: note),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const BuildBottomNavigationBar(
      //   selectedIndex: 0,
      // ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<NotificationData>('notes', notes));
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.note}) : super(key: key);

  final NotificationData note;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.fromLTRB(size.width * 0.02, size.height * 0.01,
          size.width * 0.02, size.height * 0.01),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Text(
          note.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
