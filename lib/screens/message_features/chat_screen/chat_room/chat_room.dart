import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../../models/authentication/user_model.dart';
import '../../../../models/chat/temp_class.dart';
import '../../../../services/message/message_service.dart';
import '../dialogs/chat_dialog.dart';
import '../dialogs/group_chat_dialog.dart';
import '../widgets/users_card.dart';
import 'body.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    Key? key,
    required this.chatRoomId,
  }) : super(key: key);

  final String chatRoomId;
  static String routeName = '/chat/chat_room';

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('chatRoomId', chatRoomId));
  }
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  MessageService dataService = MessageService();
  List<User> users = [];
  late UserModel thisUser;
  late User thisUserDetail;

  Future<void> getUsers() async {
    final usersId = await dataService.getAllUserInChatRoom(widget.chatRoomId);
    thisUser = Provider.of<UserModel?>(context, listen: false)!;
    for (final userId in usersId) {
      if (userId != thisUser.uid) {
        final user = await dataService.getUserById(userId);
        users.add(user);
      } else {
        thisUserDetail = await dataService.getUserById(userId);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: UsersCard(
            users: users,
            press: () {
              //TODO change name
            }),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(LineIcons.values['verticalEllipsis']),
              onPressed: () {
                showOverlay(
                    context: context,
                    users: List.from(users)..add(thisUserDetail));
              },
            );
          })
        ],
      ),
      body: const Body(),
    );
  }

  void showOverlay({required BuildContext context, required List<User> users}) {
    if (users.length == 1) {
      BotToast.showAttachedWidget(
        attachedBuilder: (_) =>
            PersonalChatDialog(user: users[0], parentContext: context),
        targetContext: context,
      );
    } else {
      BotToast.showAttachedWidget(
        attachedBuilder: (_) =>
            GroupChatDialog(parentContext: context, users: users),
        targetContext: context,
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<User>('users', users));
    properties
        .add(DiagnosticsProperty<MessageService>('dataService', dataService));
    properties.add(DiagnosticsProperty<UserModel>('thisUser', thisUser));
    properties.add(DiagnosticsProperty<User>('thisUserDetail', thisUserDetail));
  }
}
