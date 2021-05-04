import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../../models/chat/temp_class.dart';
import '../../dialogs/group_chat_dialog.dart';
import '../../widgets/users_card.dart';
import 'body.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({Key? key}) : super(key: key);

  static String routeName = '/chat/group_chat';

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    final agrs =
        ModalRoute.of(context)!.settings.arguments as GroupChatArguments;

    return Scaffold(
      appBar: AppBar(
        title: UsersCard(users: agrs.chat.users, press: () {}),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(LineIcons.values['verticalEllipsis']),
              onPressed: () {
                showOverlay(
                  context: context,
                  chat: agrs.chat,
                );
              },
            );
          })
        ],
      ),
      body: const Body(),
    );
  }

  void showOverlay({required BuildContext context, required Chat chat}) {
    BotToast.showAttachedWidget(
      attachedBuilder: (_) => GroupChatDialog(
        parentContext: context,
        chat: chat,
      ),
      targetContext: context,
    );
  }
}

class GroupChatArguments {
  GroupChatArguments({required this.chat});

  final Chat chat;
}
