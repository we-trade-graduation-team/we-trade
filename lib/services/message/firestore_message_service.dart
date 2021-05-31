import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/message_features/const_string/const_str.dart';
import 'algolia_message_service.dart';

class MessageServiceFireStore {
  MessageServiceAlgolia messageServiceAlgolia = MessageServiceAlgolia();

  Future<QuerySnapshot<Map<String, dynamic>>> getChatRoomByChatRoomId(
      String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .where(FieldPath.documentId, isEqualTo: chatRoomId)
        .get();
  }

  Future<void> createChatRoomFireStore(
      Map<String, dynamic> chatData, String id) async {
    await FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(id)
        .set(chatData)
        .catchError((dynamic onError) {});
  }

  Future<String> createChatRoomGenerateIdFireStore(
      Map<String, dynamic> chatData) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .add(chatData)
        .then((returnData) {
      return returnData.id;
    });
  }

  Future<void> addMessageToChatRoom(
      String senderId,
      int type,
      String contentToSend,
      String chatRoomId,
      String senderName,
      String image) async {
    final mapData = <String, dynamic>{
      senderIdStr: senderId,
      messageStr: contentToSend,
      typeStr: type,
      timeStr: DateTime.now().millisecondsSinceEpoch,
      senderImageStr: image,
    };

    await addMessageToFireStore(chatRoomId, mapData);

    // ignore: unawaited_futures
    messageServiceAlgolia.updateChatRoomAlgolia(
        chatRoomId, contentToSend, senderId, senderName, type);
  }

  Future<void> addMessageToFireStore(
      String chatRoomId, Map<String, dynamic> mapData) async {
    await FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(chatCollection)
        .add(mapData)
        .catchError((dynamic e) {});
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getChats(
      String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(chatCollection)
        .orderBy(timeStr)
        .snapshots();
  }

  Future<void> outOfChatRoom(String chatRoomId, String userId) async {
    await FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .get()
        .then((value) {
      final usersId =
          (value.data()![usersIdStr] as List<dynamic>).cast<String>().toList();
      usersId.removeWhere((element) => element == userId);
      value.reference.update(<String, dynamic>{usersIdStr: usersId});
    });
  }
}
