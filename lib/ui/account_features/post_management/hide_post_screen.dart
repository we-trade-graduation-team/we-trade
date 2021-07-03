import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../services/post_feature/post_service_algolia.dart';

import '../utils.dart';

enum HidePostReasonValue {
  stopTrading,
  tradedViaWeTrade,
  tradeViaOtherChannel,
}

class Reason {
  Reason({
    required this.title,
    required this.value,
  });

  String title;
  HidePostReasonValue value;

  static List<Reason> getReasons() {
    return <Reason>[
      Reason(
          title: 'Tôi không muốn bán nữa.',
          value: HidePostReasonValue.stopTrading),
      Reason(
          title: 'Đã bán qua WeTrade.',
          value: HidePostReasonValue.tradedViaWeTrade),
      Reason(
          title: 'Đã bán qua kênh khác.',
          value: HidePostReasonValue.tradeViaOtherChannel),
    ];
  }
}

class HidePostScreen extends StatefulWidget {
  const HidePostScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HidePostScreenState createState() => _HidePostScreenState();
}

class _HidePostScreenState extends State<HidePostScreen> {
  final referenceDatabase = FirebaseFirestore.instance;
  final userID = FirebaseAuth.instance.currentUser!.uid;

  List<Reason> reasons = [];
  Reason selectedReason = Reason(
      title: 'Tôi không muốn bán nữa.', value: HidePostReasonValue.stopTrading);
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    reasons = Reason.getReasons();
  }

  void setSelectedReason(Reason reason) {
    setState(() {
      selectedReason = reason;
    });
  }

  List<Widget> buildRadioReasonList() {
    final widgets = <Widget>[];
    for (final reason in reasons) {
      widgets.add(
        RadioListTile(
          title: Text(reason.title),
          value: reason,
          groupValue: selectedReason,
          onChanged: (currentReason) {
            setState(() {
              // print(currentReason!.title);
              setSelectedReason(currentReason as Reason);
              isSelected = true;
            });
          },
          selected: selectedReason == reason,
        ),
      );
    }
    return widgets;
  }

  Future<bool> _hidePost(String postID) async {
    try {
      await referenceDatabase
          .collection('users')
          .doc(userID)
          .get()
          .then((documentSnapshot) async {
        final _user = documentSnapshot.data();
        final hiddenPosts = _user!['hiddenPosts'] as List;
        final posts = _user['posts'] as List;
        final res = posts.remove(postID);

        if (res) {
          hiddenPosts.add(postID);
          final algoliaService = PostServiceAlgolia();
          // ignore: unawaited_futures
          algoliaService.updateIsHiddentPost(postId: postID, isHidden: true);

          await referenceDatabase
              .collection('posts')
              .doc(postID)
              .update({'isHidden': true});

          await referenceDatabase.collection('users').doc(userID).update({
            'hiddenPosts': hiddenPosts,
            'posts': posts,
          }).then((value) {
            return true;
          });
        }
      });
    } catch (error) {
      rethrow;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final postID = arguments['id'].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ẩn tin'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 29),
            alignment: Alignment.bottomLeft,
            child: const Text(
              'Vui lòng chọn lí do ẩn tin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...buildRadioReasonList(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (!isSelected) {
                    showMyNotificationDialog(
                        context: context,
                        title: 'Thông báo',
                        content: 'Bạn chưa chọn lí do.',
                        handleFunction: () {
                          Navigator.of(context).pop();
                        });
                  } else {
                    _hidePost(postID);
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: const Text('Ẩn'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Reason>('reasons', reasons));
    properties
        .add(DiagnosticsProperty<Reason>('selectedReason', selectedReason));
    properties.add(StringProperty('userID', userID));
    properties.add(DiagnosticsProperty<bool>('isSelected', isSelected));
    properties.add(DiagnosticsProperty<FirebaseFirestore>(
        'referenceDatabase', referenceDatabase));
  }
}
