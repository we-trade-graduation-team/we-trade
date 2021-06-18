import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../account_screen/local_widgets/getter.dart';
import 'reply_button.dart';

class RateCard extends StatelessWidget {
  const RateCard({
    Key? key,
    required this.otherSideUserID,
    required this.ratingID,
    required this.tradingID,
    required this.star,
    required this.comment,
    required this.reply,
    required this.dateTime,
    required this.isMyRateFromOther,
    required this.showingPost,
  }) : super(key: key);
  final String otherSideUserID;
  final String ratingID;
  final String tradingID;
  final int star;
  final String comment;
  final String reply;
  final DateTime dateTime;
  final bool isMyRateFromOther;
  final String showingPost;

  @override
  Widget build(BuildContext context) {
    final referenceDatabase = FirebaseFirestore.instance;
    final width = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat.yMMMMd('en_US').add_jm().format(dateTime);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 0.2,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black26,
                ),
                width: 40,
                height: 40,
                child: FutureBuilder<DocumentSnapshot>(
                    future: referenceDatabase
                        .collection('users')
                        .doc(otherSideUserID)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final user = snapshot.data!;
                        final avatarUrl = user['avatarUrl'].toString();
                        return CircleAvatar(
                          backgroundColor: Colors.black26,
                          backgroundImage: NetworkImage(
                            avatarUrl,
                            scale: 1,
                          ),
                        );
                      }

                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.black45,
                      ));
                    }),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: width * 0.7,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      child: GetUserName(
                          documentId: otherSideUserID, isStream: false),
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: star * 1.0,
                    allowHalfRating: true,
                    //itemCount: 5,
                    glowRadius: 10,
                    glowColor: Colors.yellow[100],
                    itemSize: 20,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    //onRatingUpdate: print,
                    ignoreGestures: true,
                    onRatingUpdate: (value) {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 110,
                  height: 90,
                  child: FutureBuilder<DocumentSnapshot>(
                      future: referenceDatabase
                          .collection('posts')
                          .doc(showingPost)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final post = snapshot.data!;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              post['imagesUrl'][0].toString(),
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black45,
                        ));
                      })),
              const SizedBox(width: 15),
              Expanded(
                flex: 3,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12,
                    ),
                    child: Text(comment)),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                dateFormat.toString(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          if (reply.isNotEmpty)
            getWidgetReplie(reply)
          else if (isMyRateFromOther)
            ReplyButton(ratingID: ratingID),
        ],
      ),
    );
  }

  Widget getWidgetReplie(String? replie) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black12,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.topLeft,
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText:
              isMyRateFromOther ? 'Phản hổi từ bạn' : 'Người dùng phản hồi',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: '\n',
          hintStyle: const TextStyle(height: 2),
          labelStyle: const TextStyle(
            color: AppColors.kReviewTextLabel,
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
        initialValue: replie,
        maxLines: null,
        style: const TextStyle(fontSize: 14),
        enabled: false,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('otherSideUserID', otherSideUserID));
    properties.add(StringProperty('tradingID', tradingID));
    properties.add(IntProperty('star', star));
    properties.add(StringProperty('comment', comment));
    properties.add(StringProperty('reply', reply));
    properties.add(DiagnosticsProperty<DateTime>('dateTime', dateTime));
    properties
        .add(DiagnosticsProperty<bool>('isMyRateFromOther', isMyRateFromOther));
    properties.add(StringProperty('showingPost', showingPost));
    properties.add(StringProperty('ratingID', ratingID));
  }
}
