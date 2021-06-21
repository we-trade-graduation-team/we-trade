import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../utils/routes/routes.dart';

import 'detailed_notification_screen.dart';
import 'local_widgets/notification_app_bar.dart';
import 'notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<NotificationData> notes = [];

  Future<bool> getNotificationDatas() async {
    final user = auth.currentUser!;
    final myId = user.uid;
    final _notes = <NotificationData>[];
    await FirebaseFirestore.instance
        .collection('notification')
        .where('userId', isEqualTo: myId)
        .get()
        .then((querySnapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((doc) {
        final data = NotificationData(
            title: doc['title'].toString(),
            content: doc['content'].toString(),
            seen: doc['seen'].toString().toLowerCase() == 'true',
            createAt: doc['createAt'].toString(),
            followerId: doc['followerId'].toString(),
            offererId: doc['offererId'].toString(),
            postId: doc['postId'].toString(),
            type: int.parse(doc['type'].toString()));
        _notes.add(data);
      });
      setState(() {
        notes = _notes;
      });
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          AppBar().preferredSize.height + 20,
        ),
        child: const NotificationAppBar(),
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
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FirebaseAuth>('auth', auth));
    properties.add(IterableProperty<NotificationData>('notes', notes));
  }
}

NotificationData chosenNote = const NotificationData(
    title: '',
    content: '',
    seen: true,
    createAt: '',
    followerId: '',
    offererId: '',
    postId: '',
    type: 0);

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  final NotificationData note;

  @override
  Widget build(BuildContext context) {
    chosenNote = note;
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
            screen: DetailedNotificationScreen(note: chosenNote),
            settings: const RouteSettings(
                name: Routes.detailNotificationScreenRouteName),
            withNavBar: true,
          ),
          child: Text(
            note.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
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
