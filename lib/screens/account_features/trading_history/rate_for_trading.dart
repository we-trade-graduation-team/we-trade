import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../configs/constants/assets_paths/shared_assets_root.dart';
import '../../../configs/constants/color.dart';
import '../account/account_screen.dart';
import '../account/local_widgets/getter.dart';
import '../shared_widgets/rating_bar.dart';
import '../utils.dart';

class RateForTrading extends StatefulWidget {
  const RateForTrading({
    Key? key,
    required this.tradingID,
    required this.otherSideUserID,
  }) : super(key: key);

  static const routeName = '/ratefortrading';
  final String tradingID;
  final String otherSideUserID;

  @override
  _RateForTradingState createState() => _RateForTradingState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('tradingID', tradingID));
    properties.add(StringProperty('otherSideUserID', otherSideUserID));
  }
}

class _RateForTradingState extends State<RateForTrading> {
  final userID = AccountScreen.localUserID;
  final referenceDatabase = AccountScreen.localRefDatabase;

  final _commentController = TextEditingController();
  int star = 0;
  int timeOut = 10;
  bool _isLoaded = false;
  bool _isRated = false;
  late Widget usernameText;
  late List<Widget> postTexts = <Widget>[];
  late List<Widget> postImages = <Widget>[];
  late Map<String, dynamic> rating;

  List<Widget> buildPostsList(List<Widget> postTexts, List<Widget> postImages) {
    final postsList = <Widget>[];

    for (var i = 0; i < postTexts.length; i++) {
      final widget = Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              color: Colors.amberAccent,
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(10),
              //   child: Image.asset(
              //     products[0].images[0],
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // child: postImages[i],
            ),
            const SizedBox(width: 30),
            Expanded(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 16,
                  color: kTextColor,
                ),
                child: postTexts[i],
              ),
            ),
          ],
        ),
      );
      postsList.add(widget);
    }
    return postsList;
  }

  Future<void> updateLegit(String userID, int star) async {
    try {
      await referenceDatabase
          .collection('users')
          .doc(widget.otherSideUserID)
          .get()
          .then((documentSnapshot) async {
        final _user = documentSnapshot.data();
        var legit = double.parse(_user!['legit'].toString());
        var ratingCount = _user['ratingCount'] as int;
        legit = (legit * ratingCount + star) / (++ratingCount);
        legit = double.parse(legit.toStringAsFixed(2));
        await referenceDatabase
            .collection('users')
            .doc(userID)
            .update({'legit': legit, 'ratingCount': ratingCount});
      });
    } on FirebaseException catch (_) {
      await showMyNotificationDialog(
          context: context,
          title: 'Lỗi',
          content: 'Thao tác không thành công! Vui lòng thử lại sau.',
          handleFunction: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
    }
  }

  @override
  void initState() {
    usernameText =
        GetUserName(documentId: widget.otherSideUserID, isStream: false);
    try {
      referenceDatabase
          .collection('tradings')
          .doc(widget.tradingID)
          .get()
          .then((documentSnapshot) async {
        final trading = documentSnapshot.data();
        if (trading == null) {
          await showMyNotificationDialog(
              context: context,
              title: 'Lỗi',
              content: 'Không có dữ liệu! Vui lòng thử lại.',
              handleFunction: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
        } else {
          final amIOwner = trading['owner'] == userID;
          final posts = amIOwner
              ? trading['offerUserPosts'] as List
              : trading['ownerPosts'] as List;

          for (var i = 0; i < posts.length; i++) {
            final Widget name =
                GetPostName(documentId: posts[i].toString(), isStream: false);
            postTexts.add(name);
          }

          await referenceDatabase
              .collection('ratings')
              .where('userMakeRating', isEqualTo: userID)
              .where('trading', isEqualTo: widget.tradingID)
              .get()
              .then((querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                rating = querySnapshot.docs[0].data();
                star = rating['star'] as int;
                _commentController.text = rating['comment'].toString();
                _isRated = true;
                _isLoaded = true;
              });
            } else {
              setState(() {
                _isLoaded = true;
              });
            }
          }).timeout(Duration(seconds: timeOut));
        }
      });
    } on FirebaseException catch (_) {
      showMyNotificationDialog(
          context: context,
          title: 'Lỗi',
          content: 'Tải dữ liệu không thành công. Vui lòng thử lại!',
          handleFunction: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
    }

    super.initState();
  }

  Future<void> sendRating({
    required String tradingID,
    required String userMakeRating,
    required String userBeRated,
    required int star,
    required String comment,
  }) {
    final rating = {
      'trading': tradingID,
      'userMakeRating': userMakeRating,
      'userBeRated': userBeRated,
      'star': star,
      'comment': comment,
      'createAt': DateTime.now(),
    };

    return referenceDatabase.collection('ratings').add(rating).then((_) {
      updateLegit(userBeRated, star);
      showMyNotificationDialog(
          context: context,
          title: 'Thông báo',
          content: 'Đánh giá giao dịch thành công!',
          handleFunction: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final products = [
    //   productsData[0],
    //   productsData[1],
    // ];
    const titleWidth = 100.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá giao dịch'),
      ),
      body: _isLoaded
          ? GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Column(
                    children: [
                      Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: titleWidth,
                              child: const Text(
                                'Người dùng',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                    '$chatScreenAvaFolder/user.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 25),
                                Container(
                                  width: width * 0.5,
                                  child: DefaultTextStyle(
                                    style: const TextStyle(
                                      fontSize: 21,
                                      color: kPrimaryColor,
                                    ),
                                    child: usernameText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: titleWidth,
                              child: const Text(
                                'Sản phẩm',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ...buildPostsList(postTexts, postImages),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: kTextColor,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: titleWidth,
                              child: const Text(
                                'Số sao',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (_isRated)
                              RatingBar.builder(
                                initialRating: star * 1.0,
                                allowHalfRating: true,
                                //itemCount: 5,
                                glowRadius: 10,
                                glowColor: Colors.yellow[100],
                                itemSize: 20,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                //onRatingUpdate: print,
                                ignoreGestures: true,
                                onRatingUpdate: (value) {},
                              )
                            else
                              MyRatingBar(
                                onRatingSelected: (_star) {
                                  setState(() {
                                    star = _star;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            width: titleWidth,
                            child: const Text(
                              'Nhận xét',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (_isRated)
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _commentController.text,
                                style: const TextStyle(fontSize: 15),
                              ),
                            )
                          else
                            TextField(
                              controller: _commentController,
                              maxLength: 200,
                              decoration: const InputDecoration(
                                labelText: 'Nhận xét giao dịch',
                                hintText: 'Nhập lời nhận xét...',
                              ),
                              maxLines: 4,
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isRated
                    ? null
                    : () async {
                        await showMyConfirmationDialog(
                            context: context,
                            title: 'Thông báo',
                            content:
                                'Bạn muốn gửi đánh giá này chứ? Thao tác này chỉ được thực hiện một lần.',
                            onConfirmFunction: () {
                              sendRating(
                                tradingID: widget.tradingID,
                                userMakeRating: userID,
                                userBeRated: widget.otherSideUserID,
                                star: star,
                                comment: _commentController.text,
                              );
                              Navigator.of(context).pop();
                            },
                            onCancelFunction: () {
                              Navigator.of(context).pop();
                            });
                      },
                style: ElevatedButton.styleFrom(
                  primary: _isRated ? Colors.grey : kPrimaryColor,
                ),
                child: Text(
                    _isRated ? 'Bạn đã thực hiện đánh giá này rồi' : 'Gửi'),
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
    properties.add(StringProperty('userID', userID));
    properties.add(DiagnosticsProperty<DocumentReference<Map<String, dynamic>>>(
        'referenceDatabase', referenceDatabase));
    properties.add(IntProperty('timeOut', timeOut));
    properties.add(DiagnosticsProperty<Map<String, dynamic>>('rating', rating));
    properties.add(IntProperty('star', star));
  }
}
