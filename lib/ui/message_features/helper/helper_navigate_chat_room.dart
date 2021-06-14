import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../models/cloud_firestore/user/user.dart';
import '../../../models/ui/chat/temp_class.dart';
import '../../../services/message/algolia_user_service.dart';
import '../../../services/message/firestore_message_service.dart';
import '../chat_screen/chat_room/chat_room.dart';
import '../const_string/const_str.dart';
import 'ulti.dart';

class HelperNavigateChatRoom {
  static void checkAndSendChatRoomOneUser(
      {required UserAlgolia user,
      required User thisUser,
      required BuildContext context}) {
    final messageServiceFireStore = MessageServiceFireStore();
    final chatRoomId =
        createChatRoomId(userId: user.id, thisUserId: thisUser.uid!);
    messageServiceFireStore
        .getChatRoomByChatRoomId(chatRoomId)
        .then((result) async {
      if (!result.exists) {
        final mapData = createChatRoomMap(users: [user], thisUser: thisUser);
        await messageServiceFireStore.createPeerToPeerChatRoomFireStore(
            mapData, chatRoomId);
        final usersId = mapData[usersIdStr] as List<String>;
        await messageServiceFireStore.createSeenHistory(chatRoomId, usersId);
        final name =
            HelperClass.finalSenderName(thisUser.username, thisUser.email);

        await startNewChatRoom(
            chatRoomId: chatRoomId,
            thisUserId: thisUser.uid!,
            thisUserName: name);
      }
      await messageServiceFireStore.getChatRoom(chatRoomId).then((value) {
        navigateToChatRoom(chatRoom: value, chatGroup: false, context: context);
      });
    });
  }

  static void checkAndSendChatRoomOneUserByIds(
      {required String userId,
      required User thisUser,
      required BuildContext context}) {
    final messageServiceFireStore = MessageServiceFireStore();
    final chatRoomId =
        createChatRoomId(userId: userId, thisUserId: thisUser.uid!);
    messageServiceFireStore
        .getChatRoomByChatRoomId(chatRoomId)
        .then((result) async {
      if (!result.exists) {
        final userServiceAlgolia = UserServiceAlgolia();
        final user = await userServiceAlgolia.getUserById(userId);
        final mapData = createChatRoomMap(users: [user], thisUser: thisUser);
        await messageServiceFireStore.createPeerToPeerChatRoomFireStore(
            mapData, chatRoomId);
        final usersId = mapData[usersIdStr] as List<String>;
        await messageServiceFireStore.createSeenHistory(chatRoomId, usersId);
        final name =
            HelperClass.finalSenderName(thisUser.username, thisUser.email);

        await startNewChatRoom(
            chatRoomId: chatRoomId,
            thisUserId: thisUser.uid!,
            thisUserName: name);
      }
      await messageServiceFireStore.getChatRoom(chatRoomId).then((value) {
        navigateToChatRoom(chatRoom: value, chatGroup: false, context: context);
      });
    });
  }

  static void sendNewChatRoomGroup(
      {required List<UserAlgolia> users,
      required User thisUser,
      required BuildContext context}) {
    final messageServiceFireStore = MessageServiceFireStore();
    final mapData = createChatRoomMap(users: users, thisUser: thisUser);
    messageServiceFireStore
        .createChatRoomGenerateIdFireStore(mapData)
        .then((chatRoomId) async {
      final name =
          HelperClass.finalSenderName(thisUser.username, thisUser.email);
      final usersId = mapData[usersIdStr] as List<String>;
      await messageServiceFireStore.createSeenHistory(chatRoomId, usersId);
      await startNewChatRoom(
          chatRoomId: chatRoomId,
          thisUserId: thisUser.uid!,
          thisUserName: name);
      await messageServiceFireStore.getChatRoom(chatRoomId).then((value) {
        navigateToChatRoom(chatRoom: value, chatGroup: true, context: context);
      });
    });
  }

  static Future<void> startNewChatRoom(
      {required String chatRoomId,
      required String thisUserId,
      required String thisUserName}) async {
    final messageServiceFireStore = MessageServiceFireStore();
    await messageServiceFireStore.addMessageToChatRoom(
        thisUserId, 0, 'hi, cùng chat nào', chatRoomId, thisUserName);
  }

  static void navigateToChatRoom(
      {required Chat chatRoom,
      required bool chatGroup,
      required BuildContext context}) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));

    pushNewScreenWithRouteSettings<void>(
      context,
      screen: ChatRoomScreen(
        chat: chatRoom,
      ),
      settings: RouteSettings(
        name: ChatRoomScreen.routeName,
      ),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  static String createChatRoomId(
      {required String userId, required String thisUserId}) {
    final chatRoomId = StringBuffer();
    final usersId = <String>[userId, thisUserId];
    usersId.sort();
    usersId.forEach(chatRoomId.write);
    return chatRoomId.toString();
  }

  static Map<String, dynamic> createChatRoomMap(
      {required List<UserAlgolia> users, required User thisUser}) {
    final usersId = <String>[];
    final usersName = <String>[];
    final usersAva = <String>[];
    final usersEmail = <String>[];
    var isGroupChat = false;

    for (final user in users) {
      usersId.add(user.id);
      usersName.add(user.name);
      usersAva.add(user.image);
      usersEmail.add(user.email);
    }
    usersId.add(thisUser.uid!);

    usersName.add((thisUser.username ?? thisUser.email)!);
    usersAva.add(thisUser.photoURL ?? '');
    usersEmail.add(thisUser.email ?? '');

    if (users.length > 1) {
      isGroupChat = true;
    }

    return <String, dynamic>{
      groupChatStr: isGroupChat,
      chatRoomNameStr: '',
      usersIdStr: usersId,
      imagesStr: usersAva,
      namesStr: usersName,
      emailsStr: usersEmail,
    };
  }
}
