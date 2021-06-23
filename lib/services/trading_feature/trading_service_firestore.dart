import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/ui/chat/chat.dart';
import '../../ui/message_features/const_string/const_str.dart';
import '../../ui/message_features/helper/helper_navigate_chat_room.dart';

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
      final tradingId = await FirebaseFirestore.instance
          .collection(tradingsCollectionStr)
          .add(trading)
          .then((value) => value.id);
      await Future.wait([
        updateTradingListInUser(userId: owner, tradingId: tradingId),
        updateTradingListInUser(userId: makeOfferUser, tradingId: tradingId),
        updateLatestTrading(
          thisUserId: makeOfferUser,
          otherUserId: owner,
          tradingId: tradingId,
        ),
      ]);
    } on FirebaseException catch (_) {
      // print('Lỗi make offer: $error');
    }
  }

  Future<void> updateTradingListInUser(
      {required String userId, required String tradingId}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      final tradingList = (value.data()!['tradingHistory'] as List<dynamic>)
          .cast<String>()
          .toList();
      if (!tradingList.contains(tradingId)) {
        tradingList.add(tradingId);
        value.reference.update({
          'tradingHistory': tradingList,
        });
      }
    });
  }

  Future<void> updateLatestTrading(
      {required String thisUserId,
      required String otherUserId,
      required String tradingId}) async {
    final chatRoomId = HelperNavigateChatRoom.createChatRoomId(
        userId: otherUserId, thisUserId: thisUserId);
    await FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(latestTradingStr)
        .doc(chatRoomId)
        .set(<String, dynamic>{
      latestTradingStr: tradingId,
    }, SetOptions(merge: true));
  }

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>>
      getLatestTradingForChatRoom({required String chatRoomId}) async {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(latestTradingStr)
        .doc(chatRoomId)
        .snapshots();
  }

  Future<Trading> getTradingByTradingId({required String tradingId}) async {
    return FirebaseFirestore.instance
        .collection(tradingsCollectionStr)
        .doc(tradingId)
        .get()
        .then((value) {
      final id = value.id;
      final ownerId = value.data()!['owner'].toString();
      final ownerPost = (value.data()!['ownerPosts'] as List<dynamic>)
          .cast<String>()
          .toList();
      final offerId = value.data()!['makeOfferUser'].toString();
      final offerPosts = (value.data()!['offerUserPosts'] as List<dynamic>)
          .cast<String>()
          .toList();
      final status = int.parse(value.data()!['status'].toString());
      final money = int.parse(value.data()!['money'].toString());
      final isHaveMoney = money != 0;

      final trading = Trading(
          id: id,
          ownerId: ownerId,
          ownerPost: ownerPost[0],
          offerId: offerId,
          offerPosts: offerPosts,
          money: money,
          isHaveMoney: isHaveMoney,
          status: status);

      return trading;
    });
  }

  Future<int> getStatusOfTrading(String tradingId) {
    return FirebaseFirestore.instance
        .collection(tradingsCollectionStr)
        .doc(tradingId)
        .get()
        .then((value) => int.parse(value.data()!['status'].toString()));
  }

  Future<int> updateStatusOfTradingById(
      {required String tradingId, required int status}) {
    return FirebaseFirestore.instance
        .collection(tradingsCollectionStr)
        .doc(tradingId)
        .get()
        .then((value) {
      final oldStatus = int.parse(value.data()!['status'].toString());
      if (oldStatus == 2) {
        value.reference.update({'status': status});
        return status;
      }
      return oldStatus;
    });
  }

  Future<void> updatePostsWhenTradingSuccess(Trading trading) async {
    final offerId = trading.offerId;
    final offerPosts = trading.offerPosts;
    final ownerId = trading.ownerId;
    final ownerPost = trading.ownerPost;
    if (offerPosts.isNotEmpty) {
      await updateUserPostAndHiddenPost(offerId, offerPosts);
    }
    await updateUserPostAndHiddenPost(ownerId, [ownerPost]);
  }

  Future<void> updateUserPostAndHiddenPost(
      String userId, List<String> postsId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((documentSnapshot) async {
      final _user = documentSnapshot.data();
      final hiddenPosts = _user!['hiddenPosts'] as List;
      final posts = _user['posts'] as List;
      postsId.forEach(posts.remove);
      postsId.forEach(hiddenPosts.add);

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'hiddenPosts': hiddenPosts,
        'posts': posts,
      });

      for (final postId in postsId) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({'isHidden': true});
      }
    });
  }
}
