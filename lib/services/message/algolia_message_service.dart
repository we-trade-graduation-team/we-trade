import 'dart:developer';

import 'package:algolia/algolia.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:we_trade/models/authentication/user_model.dart';
import '../../models/chat/temp_class.dart';
import '../../screens/message_features/const_string/const_str.dart';
import '../algolia/algolia.dart';

class MessageServiceAlgolia {
  final Algolia algolia = Application.algolia;

  Future<List<AlgoliaObjectSnapshot>> searchUserByAlgolia(String query) {
    return algolia.instance
        .index(trangUsers)
        .query(query)
        .getObjects()
        .then((result) => result.hits);
  }

  Future<User> getUserById(String id) async {
    return algolia.instance
        .index(trangUsers)
        .object(id)
        .getObject()
        .then((value) {
      final user = User(
          id: id,
          name: value.data[nameStr].toString(),
          image: value.data[imageStr].toString(),
          email: value.data[emailStr].toString(),
          isActive: value.data[isActiveStr] as bool,
          activeAt: value.data[activeAtStr].toString());
      return user;
    });
  }

  Future<void> createChatRoomAlgolia(
      Map<String, dynamic> chatData, String id) async {
    chatData['objectID'] = id;
    await algolia.instance.index(trangChatRooms).addObject(chatData);
  }

  Future<Map<String, dynamic>> getImagesAndChatRoomNameAndOtherUsersId(
      String chatRoomId, String thisUserId) {
    return Future.delayed(const Duration(seconds: 2), () async {
      return algolia.instance
          .index(trangChatRooms)
          .object(chatRoomId)
          .getObject();
    }).then((value) {
      final otherUsersId =
          (value.data[usersIdStr] as List<dynamic>).cast<String>().toList();
      final allImages =
          (value.data[usersImageStr] as List<dynamic>).cast<String>().toList();
      final groupChat = value.data[isGroupChatStr] as bool;
      var chatRoomName = value.data[chatRoomNameStr].toString();

      if (!groupChat) {
        // nếu là ko phải group thì trả ra image và name ng còn lại (otherUser)
        final names =
            (value.data[usersNameStr] as List<dynamic>).cast<String>().toList();
        for (var i = 0; i < 2; i++) {
          if (otherUsersId[i] == thisUserId) {
            allImages.removeAt(i);
            names.removeAt(i);
            chatRoomName = names[0];
            break;
          }
        }
      }
      otherUsersId.removeWhere((element) => element == thisUserId);
      return <String, dynamic>{
        usersImageStr: allImages,
        chatRoomNameStr: chatRoomName,
        usersIdStr: otherUsersId,
      };
    });
  }

//hàm này t lấy đc list<users_id> và t muốn trả ra list<User> trong
//chat room này
  Future<List<User>> getAllUserInChatRoom(String chatRoomId) {
    return algolia.instance
        .index(trangChatRooms)
        .object(chatRoomId)
        .getObject()
        .then((value) async {
      final users = <User>[];
      final usersId =
          (value.data[usersIdStr] as List<dynamic>).cast<String>().toList();
      for (final userid in usersId) {
        final user = await getUserById(userid);
        users.add(user);
      }
      return users;
    });
  }

  Future<void> updateChatRoomAlgolia(String chatRoomId, String contentToSend,
      String senderId, String name, int type) async {
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

    final object =
        await Future.delayed(const Duration(milliseconds: 1500), () async {
      return algolia.instance
          .index(trangChatRooms)
          .object(chatRoomId)
          .getObject();
    });

    final updateData = Map<String, dynamic>.from(object.data);
    updateData[lastMessageStr] = lastMessage;
    updateData[senderIdStr] = senderId;
    updateData[senderNameStr] = name;
    updateData[timeStr] = DateFormat.yMd().add_jm().format(DateTime.now());
    await algolia.instance
        .index(trangChatRooms)
        .object(chatRoomId)
        .updateData(updateData);
  }

  Future<List<Chat>> getAllChatRooms(String userId) {
    final chats = <Chat>[];
    return algolia.instance
        .index(trangChatRooms)
        .facetFilter('$usersIdStr:$userId')
        .getObjects()
        .then((value) {
      for (final snapShot in value.hits) {
        chats.add(Chat(
          chatRoomId: snapShot.objectID,
          images: (snapShot.data[usersImageStr] as List<dynamic>)
              .cast<String>()
              .toList(),
          lastMessage: snapShot.data[lastMessageStr].toString(),
          chatRoomName: snapShot.data[chatRoomNameStr].toString(),
          senderName: snapShot.data[senderNameStr].toString(),
          time: snapShot.data[timeStr].toString(),
          senderId: snapShot.data[senderIdStr].toString(),
          usersId: (snapShot.data[usersIdStr] as List<dynamic>)
              .cast<String>()
              .toList(),
          names: (snapShot.data[usersNameStr] as List<dynamic>)
              .cast<String>()
              .toList(),
          emails: (snapShot.data[emailsStr] as List<dynamic>)
              .cast<String>()
              .toList(),
          groupChat: snapShot.data[isGroupChatStr] as bool,
        ));
      }
      chats.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(b.time)
          .compareTo(DateFormat.yMd('en_US').add_jm().parse(a.time)));
      return chats;
    });
  }

//TODO out group chat
  Future<void> outOfChatRoom(String chatRoomId, UserModel user) async {
    final object =
        await Future.delayed(const Duration(milliseconds: 1500), () async {
      return algolia.instance
          .index(trangChatRooms)
          .object(chatRoomId)
          .getObject();
    });
    final updateData = Map<String, dynamic>.from(object.data);
  }

  Future<void> changeGroupChatName(
      String chatRoomId, String newChatRoomName) async {
    final object =
        await Future.delayed(const Duration(milliseconds: 1500), () async {
      return algolia.instance
          .index(trangChatRooms)
          .object(chatRoomId)
          .getObject();
    });
    final updateObject = Map<String, dynamic>.from(object.data);
    updateObject[chatRoomNameStr] = newChatRoomName;
    await algolia.instance
        .index(trangChatRooms)
        .object(chatRoomId)
        .updateData(updateObject);
  }
}
