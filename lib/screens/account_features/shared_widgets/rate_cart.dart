import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../../../configs/constants/color.dart';
import '../account/local_widgets/getter.dart';

class RateCard extends StatelessWidget {
  const RateCard({
    Key? key,
    required this.otherSideUserID,
    required this.tradingID,
    required this.star,
    required this.comment,
    required this.reply,
    required this.dateTime,
    required this.isMyRateFromOther,
  }) : super(key: key);
  final String otherSideUserID;
  final String tradingID;
  final int star;
  final String comment;
  final String reply;
  final DateTime dateTime;
  final bool isMyRateFromOther;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat.yMMMMd('en_US').add_jm().format(dateTime);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        //color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: kTextColor,
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
                // child: CircleAvatar(
                //   child: CircleAvatar(
                //     radius: 100,
                //     backgroundImage: AssetImage(review.user.image),
                //   ),
                // ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.amber,
                ),
                width: 40,
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: width * 0.7,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 15,
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
              Expanded(
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child: Image.asset(
                //     review.product.images[0],
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 70,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 3,
                child: Text(comment),
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
          if (reply != '') getWidgetReplie(reply),
        ],
      ),
    );
  }

  Widget getWidgetReplie(String? replie) {
    return Container(
      decoration: BoxDecoration(
        color: kBackGroundColor,
        borderRadius: BorderRadius.circular(5),
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
            color: kReviewTextLabel,
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
  }
}
