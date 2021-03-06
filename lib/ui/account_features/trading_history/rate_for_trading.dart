import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../services/post_feature/post_service_firestore.dart';
import '../account_screen/local_widgets/getter.dart';
import '../shared_widgets/rating_bar.dart';
import '../utils.dart';

class RateForTrading extends StatefulWidget {
  const RateForTrading({
    Key? key,
    required this.tradingID,
    required this.otherSideUserID,
  }) : super(key: key);

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
  final userID = FirebaseAuth.instance.currentUser!.uid;
  final referenceDatabase = FirebaseFirestore.instance;

  final _commentController = TextEditingController();
  int star = 0;
  int timeOut = 10;
  bool _isLoaded = false;
  bool _isRated = false;
  late Widget usernameText;
  late List<Widget> postTexts = <Widget>[];
  late List<Widget> postImages = <Widget>[];
  late Map<String, dynamic> rating;
  String money = '0';
  late String post; //ngo nha chang

  List<Widget> _buildPostsList(
      List<Widget> postTexts, List<Widget> postImages) {
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
              child: postImages[i],
            ),
            const SizedBox(width: 30),
            Expanded(
              child: DefaultTextStyle(
                style:
                    const TextStyle(fontSize: 16, color: AppColors.kTextColor),
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
            Navigator.of(context).pop(false);
            Navigator.of(context).pop(false);
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
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
              });
        } else {
          final amIOwner = trading['owner'] == userID;
          final posts = amIOwner
              ? trading['offerUserPosts'] as List
              : trading['ownerPosts'] as List;
          money = trading['money'].toString();
          post = posts[0].toString(); //ngo nha chang

          for (var i = 0; i < posts.length; i++) {
            final Widget name =
                GetPostName(documentId: posts[i].toString(), isStream: false);
            postTexts.add(name);

            final Widget image = FutureBuilder<DocumentSnapshot>(
                future: referenceDatabase
                    .collection('posts')
                    .doc(posts[i].toString())
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
                });
            postImages.add(image);
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
            Navigator.of(context).pop(false);
            Navigator.of(context).pop(false);
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
    required String post,
  }) {
    final rating = {
      'trading': tradingID,
      'userMakeRating': userMakeRating,
      'userBeRated': userBeRated,
      'star': star,
      'comment': comment,
      'createAt': DateTime.now(),
      'reply': '',
      'post': post,
    };

    final postFireStoreServier = PostServiceFireStore();
    postFireStoreServier.updatePriorityOfUser(userMakeRating);

    return referenceDatabase.collection('ratings').add(rating).then((_) {
      updateLegit(userBeRated, star);
      showMyNotificationDialog(
          context: context,
          title: 'Thông báo',
          content:
              'Đánh giá giao dịch thành công! Các bài đăng của bạn đã được cộng điểm ưu tiên.',
          handleFunction: () {
            Navigator.of(context).pop(true);
            Navigator.of(context).pop(true);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
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
                                    AppAssets.firstWalkThroughImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 25),
                                Container(
                                  width: width * 0.5,
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: Theme.of(context).primaryColor),
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
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
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
                            const SizedBox(height: 15),
                            ..._buildPostsList(postTexts, postImages),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: titleWidth,
                              child: const Text(
                                'Số tiền: ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              '$money  VND',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
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
              child: CircularProgressIndicator(),
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
                                comment: _commentController.text.trim(),
                                post: post,
                              );
                              Navigator.of(context).pop(true);
                            },
                            onCancelFunction: () {
                              Navigator.of(context).pop(false);
                            });
                      },
                style: ElevatedButton.styleFrom(
                  primary:
                      _isRated ? Colors.grey : Theme.of(context).primaryColor,
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
    properties.add(IntProperty('timeOut', timeOut));
    properties.add(DiagnosticsProperty<Map<String, dynamic>>('rating', rating));
    properties.add(IntProperty('star', star));
    properties.add(StringProperty('post', post));
    properties.add(DiagnosticsProperty<FirebaseFirestore>(
        'referenceDatabase', referenceDatabase));
    properties.add(StringProperty('money', money));
  }
}
