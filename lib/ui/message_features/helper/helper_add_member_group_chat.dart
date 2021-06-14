import 'package:flutter/material.dart';
import '../../../models/cloud_firestore/user_model/user/user.dart';

import '../../../models/ui/chat/temp_class.dart';
import '../../../services/message/firestore_message_service.dart';
import '../chat_screen/chat_room/chat_room.dart';
import 'ulti.dart';

class HelperAddMemberGroupChat {
  static Future<void> addUserToGroupChat(
      {required List<UserAlgolia> users,
      required User thisUser,
      required String chatRoomId,
      required BuildContext context}) async {
    final messageServiceFireStore = MessageServiceFireStore();
    final usersId = <String>[];
    final usersName = <String>[];
    final usersImage = <String>[];
    final usersEmail = <String>[];

    for (final user in users) {
      usersId.add(user.id);
      usersName.add(user.name);
      usersImage.add(user.image);
      usersEmail.add(user.email);
    }

    final name = HelperClass.finalSenderName(thisUser.name, thisUser.email);

    // ignore: unawaited_futures
    await messageServiceFireStore
        .addUsersToGroupChat(
            chatRoomId, name, usersId, usersImage, usersEmail, usersName)
        .then((value) {
      Navigator.of(context).popUntil((route) {
        return route.settings.name == ChatRoomScreen.routeName;
      });
    });
  }
}
