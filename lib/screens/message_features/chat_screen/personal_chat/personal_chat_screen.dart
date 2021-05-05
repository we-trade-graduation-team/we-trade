import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../models/chat/temp_class.dart';
import '../dialogs/chat_dialog.dart';
import '../widgets/user_card.dart';
import 'body.dart';

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/chat/personal_chat';

  @override
  _PersonalChatScreenState createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  @override
  Widget build(BuildContext context) {
    final agrs =
        ModalRoute.of(context)!.settings.arguments as PersonalChatArguments;

    return Scaffold(
      appBar: AppBar(
        title: UserCard(
            user: agrs.chat.users[0], press: () {}, showActiveAt: true),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(LineIcons.values['verticalEllipsis']),
              onPressed: () {
                showOverlay(context: context, user: agrs.chat.users[0]);
              },
            );
          })
        ],
      ),
      body: const Body(),
    );
  }

  void showOverlay({required BuildContext context, required User user}) {
    BotToast.showAttachedWidget(
      attachedBuilder: (_) => ChatDialog(user: user, parentContext: context),
      targetContext: context,
    );
  }
}

class PersonalChatArguments {
  const PersonalChatArguments({
    required this.chat,
  });

  final Chat chat;
}
