import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class TradingServiceFireStore {
  Future<String> getOwnerIdOfPost(String postId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) => value.data()!['owner'].toString());
  }

  Future<void> addTrading({
    required String makeOfferUser, // đứa bấm nút make offer
    List<String>? offerUserPosts, // bài đăng của đứa bấm make offer
    required String ownerPost, // bài đăng của đứa kia
    int? money,
  }) async {
    final owner = await getOwnerIdOfPost(ownerPost);
    final trading = <String, dynamic>{
      'createAt': DateTime.now(),
      'makeOfferUser': makeOfferUser,
      'offerUserPosts': offerUserPosts ?? [], //không có posts thì là mảng rỗng
      'owner': owner,
      'ownerPosts': [ownerPost],
      'status': 2, // đang giao dịch
      'isHaveMoney': money != null,
      'money': money ??
          0, //nếu không có tiền thì giá trị là 0,truyền vào giá trị dương
    };
    try {
      await FirebaseFirestore.instance
          .collection('tradings')
          .add(trading)
          .then((value) => log('added!'));
    } on FirebaseException catch (error) {
      log('Lỗi make offer: $error');
    }
  }
}
