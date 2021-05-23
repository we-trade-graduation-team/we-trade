import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/chat/temp_class.dart';
import '../../screens/message_features/const_string/const_str.dart';
import '../algolia/algolia.dart';

class MessageService {
  final Algolia algolia = Application.algolia;

  Future<QuerySnapshot<Map<String, dynamic>>> getUserByUserEmail(String eMail) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection('users')
        .where('E-mail', isGreaterThanOrEqualTo: eMail)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getChatRoomByChatRoomId(
      String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection('chat_rooms')
        .where(FieldPath.documentId, isEqualTo: chatRoomId)
        .get();
  }

  Future<List<AlgoliaObjectSnapshot>> getUserByAlgolia(String query) {
    return algolia.instance
        .index(trangUsers)
        .query(query)
        .getObjects()
        .then((result) => result.hits);
  }

  void createChatRoomFireStore(Map<String, dynamic> chatData, String id) {
    FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection('chat_rooms')
        .doc(id)
        .set(chatData)
        // ignore: avoid_print
        .catchError((dynamic onError) => print(onError.toString()));
  }

  void createChatRoomAlgolia(Map<String, dynamic> chatData, String id) {
    chatData['objectID'] = id;
    algolia.instance.index(trangChatRooms).addObject(chatData);
  }

  Future<List<String>> getAllUserInChatRoom(String objectID) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection('chat_rooms')
        .where(FieldPath.documentId, isEqualTo: objectID)
        .get()
        .then((value) {
      final result = (value.docs[0].data()['users'] as List<dynamic>)
          .cast<String>()
          .toList();
      return result;
    });
  }

  Future<User> getUserById(String objectID) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection('users')
        .where(FieldPath.documentId, isEqualTo: objectID)
        .get()
        .then((value) {
      final user = User(
          id: objectID,
          name: value.docs[0].data()['name'].toString(),
          image: value.docs[0].data()['image'].toString(),
          email: value.docs[0].data()['E-mail'].toString(),
          isActive: value.docs[0].data()['is_active'] as bool,
          activeAt: value.docs[0].data()['active_at'].toString());
      return user;
    });
  }
}
