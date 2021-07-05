import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../models/ui/chat/chat.dart';

import '../const_string/const_str.dart';

class HelperClass {
  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      barrierColor: Colors.grey[300]!.withOpacity(0.5),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Lottie.network(
              messageLoadingStr2,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            const Text(loadingDataStr),
          ],
        ),
      ),
    );
  }

  static String finalSenderName(String? name, String? email) {
    if (name == null) {
      return email!;
    }
    return (name.isNotEmpty ? name : email)!;
  }

  static String finalChatName(List<String> names) {
    final chatName = StringBuffer();
    for (final user in names) {
      chatName.write('$user, ');
    }
    final result = chatName.toString();
    return result.substring(0, result.length - 2);
  }

  static Map<String, dynamic> getImagesAndChatRoomName(
      Chat chat, String thisUserId) {
    if (!chat.groupChat) {
      var otherUserIndex = 0;
      for (var i = 0; i < chat.usersId.length; i++) {
        if (chat.usersId[i] != thisUserId) {
          otherUserIndex = i;
          break;
        }
      }
      return <String, dynamic>{
        imagesStr: [chat.images[otherUserIndex]],
        chatRoomNameStr: finalSenderName(
            chat.names[otherUserIndex], chat.emails[otherUserIndex]),
      };
    } else {
      return <String, dynamic>{
        imagesStr: chat.images,
        chatRoomNameStr: chat.chatRoomName,
      };
    }
  }
}
