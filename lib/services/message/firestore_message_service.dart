import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../models/cloud_firestore/user/user.dart';

import '../../models/ui/chat/temp_class.dart';
import '../../ui/message_features/const_string/const_str.dart';
import '../../ui/message_features/helper/ulti.dart';
import 'algolia_user_service.dart';

class MessageServiceFireStore {
  UserServiceAlgolia userServiceAlgolia = UserServiceAlgolia();

  Future<DocumentSnapshot<Map<String, dynamic>>> getChatRoomByChatRoomId(
      String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .get();
  }

  Future<List<String>> getAllUsersIdInChatRoom(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .get()
        .then((value) {
      return (value.get(usersIdStr) as List<dynamic>).cast<String>().toList();
    });
  }

  Future<void> createPeerToPeerChatRoomFireStore(
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
      return returnData.get().then((value) => value.id);
    });
  }

  Future<void> addMessageToChatRoom(String senderId, int type,
      String contentToSend, String chatRoomId, String senderName) async {
    final mapData = <String, dynamic>{
      senderIdStr: senderId,
      messageStr: contentToSend,
      typeStr: type,
      timeStr: DateTime.now().millisecondsSinceEpoch
    };

    await addMessageToFireStore(chatRoomId, mapData);

    updateChatRoom(chatRoomId, contentToSend, senderId, senderName, type);
  }

  void updateChatRoom(String chatRoomId, String contentToSend, String senderId,
      String name, int type) {
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

    FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .update({
      lastMessageStr: lastMessage,
      senderIdStr: senderId,
      senderNameStr: name,
      timeStr: DateTime.now().millisecondsSinceEpoch
    });
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
        .orderBy(timeStr, descending: true)
        .snapshots();
  }

  Future<List<UserAlgolia>> getAllUserInChatRoom(String chatRoomId) {
    return getAllUsersIdInChatRoom(chatRoomId).then((usersId) async {
      final users = <UserAlgolia>[];
      for (final userid in usersId) {
        final user = await userServiceAlgolia.getUserById(userid);
        users.add(user);
      }
      return users;
    });
  }

  Future<Chat> getChatRoom(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .get()
        .then((value) {
      return createChatFromData(value.data()!, value.id);
    });
  }

  Chat createChatFromData(Map<String, dynamic> snapShot, String id) {
    var chatRoomName = '';
    if (snapShot[chatRoomNameStr].toString().isNotEmpty) {
      chatRoomName = snapShot[chatRoomNameStr].toString();
    } else {
      if (snapShot[groupChatStr] as bool) {
        chatRoomName = HelperClass.finalChatName(
            (snapShot[namesStr] as List<dynamic>).cast<String>().toList());
      }
    }
    final lastActive = DateFormat.yMd('en_US').add_jm().format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(snapShot[timeStr].toString())));
    return Chat(
      chatRoomId: id,
      images: (snapShot[imagesStr] as List<dynamic>).cast<String>().toList(),
      lastMessage: snapShot[lastMessageStr].toString(),
      chatRoomName: chatRoomName,
      senderName: snapShot[senderNameStr].toString(),
      time: lastActive,
      senderId: snapShot[senderIdStr].toString(),
      usersId: (snapShot[usersIdStr] as List<dynamic>).cast<String>().toList(),
      names: (snapShot[namesStr] as List<dynamic>).cast<String>().toList(),
      emails: (snapShot[emailsStr] as List<dynamic>).cast<String>().toList(),
      groupChat: snapShot[groupChatStr] as bool,
    );
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
      final allImages =
          (value.data()![imagesStr] as List<dynamic>).cast<String>().toList();
      final allNames =
          (value.data()![namesStr] as List<dynamic>).cast<String>().toList();
      final allEmails =
          (value.data()![emailsStr] as List<dynamic>).cast<String>().toList();

      var thisUserName = '';
      for (var i = 0; i < usersId.length; i++) {
        if (usersId[i] == userId) {
          thisUserName = HelperClass.finalSenderName(allNames[i], allEmails[i]);
          usersId.removeAt(i);
          allImages.removeAt(i);
          allNames.removeAt(i);
          allEmails.removeAt(i);
          break;
        }
      }

      value.reference.update(<String, dynamic>{
        usersIdStr: usersId,
        imagesStr: allImages,
        namesStr: allNames,
        emailsStr: allEmails,
      });
      final contentToSend = '$thisUserName đã rời group';
      addMessageToChatRoom('', 0, contentToSend, chatRoomId, '');
    });
  }

  Future<void> changeGroupChatName(
      String chatRoomId, String newGroupName) async {
    await FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .update({chatRoomNameStr: newGroupName});
  }

  Future<void> addUsersToGroupChat(
    String chatRoomId,
    String myName,
    List<String> usersId,
    List<String> usersImage,
    List<String> usersEmail,
    List<String> usersName,
  ) async {
    var message = '$myName đã thêm ';
    await getChatRoom(chatRoomId).then((chatRoom) async {
      for (var i = 0; i < usersId.length; i++) {
        if (!chatRoom.usersId.contains(usersId[i])) {
          message += '${usersName[i]}, ';
          chatRoom.usersId.add(usersId[i]);
          chatRoom.images.add(usersImage[i]);
          chatRoom.emails.add(usersEmail[i]);
          chatRoom.names.add(usersName[i]);
        }
      }

      if (message != '$myName  đã thêm ') {
        //update data chatroom
        await FirebaseFirestore.instance
            .collection('trang')
            .doc('nzTptOzmSw1IbLfKHxOT')
            .collection(chatRoomCollection)
            .doc(chatRoomId)
            .update({
          emailsStr: chatRoom.emails,
          namesStr: chatRoom.names,
          imagesStr: chatRoom.images,
          usersIdStr: chatRoom.usersId,
        });

        //add chat to chat room
        message = message.substring(0, message.length - 2);
        // ignore: unawaited_futures
        addMessageToChatRoom('', 0, message, chatRoomId, '');
      }
    });
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllChatRooms(
      String userId) async {
    return FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .where(usersIdStr, arrayContains: userId)
        //.orderBy(timeStr)
        .snapshots();
  }

  Future<void> updateChatRoomsWhenUpdateUser(User user) async {
    await FirebaseFirestore.instance
        .collection('trang')
        .doc('nzTptOzmSw1IbLfKHxOT')
        .collection(chatRoomCollection)
        .where(usersIdStr, arrayContains: user.uid)
        .get()
        .then((value) {
      for (final snapShot in value.docs) {
        final chat = createChatFromData(snapShot.data(), snapShot.id);
        for (var i = 0; i < chat.usersId.length; i++) {
          if (chat.usersId[i] == user.uid) {
            chat.images[i] = user.photoURL!;
            chat.names[i] = user.displayName!;
            chat.emails[i] = user.email!;
            break;
          }
        }

        snapShot.reference.update(<String, dynamic>{
          imagesStr: chat.images,
          namesStr: chat.names,
          emailsStr: chat.emails,
        });
      }
    });
  }
}
