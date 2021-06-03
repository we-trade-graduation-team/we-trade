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

    var lastMessage = '';
    switch (type) {
      case 0:
        lastMessage = contentToSend;
        break;
      case 1:
        lastMessage = 'Gửi một ảnh';
        break;
      case 2:
        lastMessage = 'Gửi một video';
        break;
      case 3:
        lastMessage = 'Gửi một clip thoại';
        break;

      default:
        lastMessage = '';
        break;
    }
    await messageServiceAlgolia.updateChatRoomAlgolia(
        chatRoomId, lastMessage, senderId, senderName);
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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getChats(
      String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(chatCollection)
        .orderBy(timeStr)
        .get()
        .then((value) {
      final result = value.docs;
      return result;
    });
  }
}
