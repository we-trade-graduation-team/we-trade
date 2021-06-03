import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/ui/chat/temp_class.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({
    Key? key,
    required this.users,
    required this.press,
  }) : super(key: key);

  final List<User> users;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(users[0].image),
                    ),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(users[1].image),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      finalChatName(users),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String finalChatName(List<User> users) {
    final chatName = StringBuffer();
    for (final user in users) {
      chatName.write('${user.name}, ');
    }
    final result = chatName.toString();
    return result.substring(0, result.length - 2);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(IterableProperty<User>('users', users));
  }
}
