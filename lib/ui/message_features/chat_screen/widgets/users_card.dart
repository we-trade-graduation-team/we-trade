import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../models/ui/chat/temp_class.dart';

import '../../../../widgets/custom_user_avatar.dart';
import '../../const_string/const_str.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({
    Key? key,
    required this.press,
    required this.images,
    this.isActive = false,
    required this.chatName,
  }) : super(key: key);

  final List<String> images;
  final bool isActive;
  final String chatName;
  final VoidCallback press;

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
      for (var i = 0; i < 2; i++) {
        if (chat.usersId[i] != thisUserId) {
          otherUserIndex = i;
          break;
        }
      }
      return <String, dynamic>{
        usersImageStr: [chat.images[otherUserIndex]],
        chatRoomNameStr: chat.names[otherUserIndex],
      };
    } else {
      return <String, dynamic>{
        usersImageStr: chat.images,
        chatRoomNameStr: chat.chatRoomName,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    if (images.isNotEmpty) {
      return InkWell(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              if (images.length > 2)
                Container(
                  width: 48,
                  height: 48,
                  child: Stack(
                    children: [
                      CustomUserAvatar(image: images[1], radius: 16),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: CustomUserAvatar(
                                image: images[0], radius: 16 - 2)),
                      ),
                    ],
                  ),
                )
              else
                Stack(
                  children: [
                    CustomUserAvatar(image: images[0], radius: 24),
                    if (isActive)
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
                      )
                  ],
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    chatName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(StringProperty('chatName', chatName));
    properties.add(IterableProperty<String>('images', images));
    properties.add(DiagnosticsProperty<bool>('isActive', isActive));
  }
}
