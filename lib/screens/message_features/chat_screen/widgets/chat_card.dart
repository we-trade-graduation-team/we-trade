import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/chat/temp_class.dart';
import '../../../../widgets/custom_user_avatar.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);

  final Chat chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Stack(
              children: [
                if (chat.users.length == 1)
                  CustomUserAvatar(image: chat.users[0].image, radius: 24),
                //buildAvatarChat(chat.users[0].image, 24),
                if (chat.users.length == 1)
                  if (chat.users[0].isActive)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                if (chat.users.length > 1)
                  Container(
                    width: 48,
                    height: 48,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CustomUserAvatar(
                              image: chat.users[0].image, radius: 16),
                        ),
                        CustomUserAvatar(
                            image: chat.users[1].image, radius: 16),
                      ],
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      finalChatName(chat)!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        '${chat.lastMessageByUser != null ? chat.lastMessageByUser!.name : "Bạn"}: ${chat.lastMessage}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(chat.time),
            ),
          ],
        ),
      ),
    );
  }

  static String? finalChatName(Chat chat) {
    if (chat.users.length == 1) {
      return chat.users[0].name;
    }
    if (chat.chatName == null) {
      final chatName = StringBuffer();
      for (final user in chat.users) {
        chatName.write('${user.name}, ');
      }
      final result = chatName.toString();
      return result.substring(0, result.length - 2);
    }

    return chat.chatName;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Chat>('chat', chat));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
  }
}
