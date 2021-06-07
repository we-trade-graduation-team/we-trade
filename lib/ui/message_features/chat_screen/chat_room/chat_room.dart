import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/cloud_firestore/user/user.dart';
import '../../../../models/ui/chat/temp_class.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../const_string/const_str.dart';
import '../../helper/ulti.dart';
import '../dialogs/chat_dialog.dart';
import '../dialogs/group_chat_dialog.dart';
import '../widgets/users_card.dart';
import 'body.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    Key? key,
    required this.chat,
    this.chatRoomName = '',
    this.usersImage = const [],
  }) : super(key: key);

  final Chat chat;
  final String chatRoomName;
  final List<String> usersImage;
  static String routeName = '/chat/chat_room';

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('chatRoomName', chatRoomName));
    properties.add(IterableProperty<String>('usersImage', usersImage));
    properties.add(DiagnosticsProperty<Chat>('chatRoom', chat));
  }
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  MessageServiceFireStore messageServiceFireStore = MessageServiceFireStore();
  late User thisUser = Provider.of<User?>(context, listen: false)!;
  final TextEditingController newChatRoomNameController =
      TextEditingController();
  late List<String> usersImage = [];
  late String chatRoomName = '';
  late Map<String, String> userAndAva = {};

  void getImagesAndChatRoomName() {
    if (widget.usersImage.isNotEmpty && widget.chatRoomName.isNotEmpty) {
      setState(() {
        usersImage = widget.usersImage;
        chatRoomName = widget.chatRoomName;
      });
    } else {
      setState(() {
        final mapData =
            HelperClass.getImagesAndChatRoomName(widget.chat, thisUser.uid!);
        chatRoomName = mapData[chatRoomNameStr].toString();
        usersImage =
            (mapData[imagesStr] as List<dynamic>).cast<String>().toList();
      });
    }

    for (var i = 0; i < widget.chat.usersId.length; i++) {
      userAndAva[widget.chat.usersId[i]] = widget.chat.images[i];
    }
  }

  void changeGroupChatName() {
    if (widget.chat.groupChat) {
      //chạy hàm change name group chat đây
      displayTextInputDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();
    getImagesAndChatRoomName();
  }

  @override
  Widget build(BuildContext context) {
    //getImagesAndChatRoomName();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: UsersCard(
            chatName: chatRoomName,
            images: usersImage,
            press: changeGroupChatName,
          ),
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
                    chatRoomId: widget.chat.chatRoomId,
                    groupChat: widget.chat.groupChat,
                  );
                },
              );
            })
          ],
        ),
        body: Body(
          chatRoomId: widget.chat.chatRoomId,
          userAndAva: userAndAva,
        ),
      ),
    );
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    newChatRoomNameController.text = chatRoomName;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Chỉnh sửa tên nhóm'),
            content: TextFormField(
              maxLength: 100,
              controller: newChatRoomNameController,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  'Hủy',
                  style: TextStyle(color: AppColors.kTextColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  final newChatRoomName = newChatRoomNameController.text;
                  if (newChatRoomName != chatRoomName) {
                    messageServiceFireStore.changeGroupChatName(
                        widget.chat.chatRoomId, newChatRoomNameController.text);
                    setState(() {
                      chatRoomName = newChatRoomNameController.text;
                    });
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          );
        });
  }

  Future<void> showOverlay(
      {required BuildContext context,
      required bool groupChat,
      required String chatRoomId}) async {
    if (!groupChat) {
      final otherUsersId =
          widget.chat.usersId.firstWhere((element) => element != thisUser.uid);
      BotToast.showAttachedWidget(
        attachedBuilder: (_) =>
            PersonalChatDialog(userId: otherUsersId, parentContext: context),
        targetContext: context,
      );
    } else {
      BotToast.showAttachedWidget(
        attachedBuilder: (_) => GroupChatDialog(
          parentContext: context,
          chatRoomId: chatRoomId,
        ),
        targetContext: context,
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('usersImage', usersImage));
    properties.add(StringProperty('chatRoomName', chatRoomName));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'newChatRoomNameController', newChatRoomNameController));
    properties
        .add(DiagnosticsProperty<Map<String, String>>('user_ava', userAndAva));
    properties.add(DiagnosticsProperty<User>('thisUser', thisUser));
    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'messageServiceFireStore', messageServiceFireStore));
  }
}
