import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../shared_widgets/rate_cart.dart';

class RateTab extends StatefulWidget {
  const RateTab({
    Key? key,
    required this.isMyRateFromOther,
    // required this.userDetail,
  }) : super(key: key);

  final bool isMyRateFromOther;
  // final UserDetail userDetail;
  @override
  _RateTabState createState() => _RateTabState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<bool>('isMyRateFromOther', isMyRateFromOther));
  }
}

class _RateTabState extends State<RateTab> {
  final userID = FirebaseAuth.instance.currentUser!.uid;

  late FocusScopeNode node;

  @override
  void dispose() {
    node.unfocus();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);

    final referenceDatabase = FirebaseFirestore.instance;
    final field = widget.isMyRateFromOther ? 'userBeRated' : 'userMakeRating';

    return GestureDetector(
      onTap: () => node.unfocus(),
      child: FutureBuilder<QuerySnapshot>(
        future: referenceDatabase
            .collection('ratings')
            // .orderBy('createAt',  descending: true)
            .where(field, isEqualTo: userID)
            .get(),
        builder: (ctx, querySnapshot) {
          if (querySnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (querySnapshot.hasError) {
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Có lỗi xảy ra.',
                      ),
                      Text(
                        'Vui lòng thử lại sau.',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          final ratings = querySnapshot.data!.docs;

          return ratings.isNotEmpty
              ? ListView.builder(
                  itemCount: ratings.length,
                  itemBuilder: (context, index) {
                    final rating = ratings[index];
                    final otherSideUserID = widget.isMyRateFromOther
                        ? rating['userMakeRating'].toString()
                        : rating['userBeRated'].toString();
                    final timeData = rating['createAt'] as Timestamp;
                    final showingPost = rating['post'].toString();

                    return RateCard(
                      key: ValueKey(ratings[index].id.toString()),
                      ratingID: ratings[index].id.toString(),
                      otherSideUserID: otherSideUserID,
                      tradingID: rating['trading'].toString(),
                      star: rating['star'] as int,
                      comment: rating['comment'].toString(),
                      reply: rating['reply'].toString(),
                      dateTime: timeData.toDate(),
                      isMyRateFromOther: widget.isMyRateFromOther,
                      showingPost: showingPost,
                    );
                  })
              : const Center(
                  child: Text(
                    'Chưa có dữ liệu.',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black45,
                    ),
                  ),
                );
        },
      ),
    );

    // return ListView.builder(
    //   itemCount: widget.userDetail.reviews!.length,
    //   itemBuilder: (context, index) => ReviewCard(
    //     review: widget.userDetail.reviews![index],
    //     //press: () {},
    //     // press: () => Navigator.push(
    //     //   context,
    //     //   MaterialPageRoute(
    //     //     builder: (context) => MessagesScreen(),
    //     //   ),
    //   ),
    // );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userID', userID));
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
  }
}
