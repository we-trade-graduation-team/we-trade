import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/chat/temp_class.dart';
import '../../../../widgets/custom_user_avatar.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({
    Key? key,
    required this.users,
    required this.press,
    this.chatName = '',
  }) : super(key: key);

  final List<User> users;
  final String chatName;
  final VoidCallback press;

  static String finalChatName(List<String> users) {
    final chatName = StringBuffer();
    for (final user in users) {
      chatName.write('$user, ');
    }
    final result = chatName.toString();
    return result.substring(0, result.length - 2);
  }

  List<String> getUsersName() {
    final listName = <String>[];
    for (final user in users) {
      listName.add(user.name);
    }
    return listName;
  }

  @override
  Widget build(BuildContext context) {
    if (users.isNotEmpty) {
      return InkWell(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              if (users.length > 1)
                Container(
                  width: 48,
                  height: 48,
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: CustomUserAvatar(
                              image: users[0].image, radius: 16)),
                      CustomUserAvatar(image: users[1].image, radius: 16),
                    ],
                  ),
                )
              else
                Stack(
                  children: [
                    CustomUserAvatar(image: users[0].image, radius: 24),
                    if (users[0].isActive)
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
                    chatName.isEmpty ? finalChatName(getUsersName()) : chatName,
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
    properties.add(IterableProperty<User>('users', users));
    properties.add(StringProperty('chatName', chatName));
  }
}
