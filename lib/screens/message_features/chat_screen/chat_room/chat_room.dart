import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../../../../configs/constants/color.dart';

import '../../../../models/authentication/user_model.dart';
import '../../../../services/message/algolia_message_service.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../const_string/const_str.dart';
import '../dialogs/chat_dialog.dart';
import '../dialogs/group_chat_dialog.dart';
import '../widgets/users_card.dart';
import 'body.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    Key? key,
    required this.chatRoomId,
    required this.groupChat,
    this.chatRoomName = '',
    this.usersImage = const [],
  }) : super(key: key);

  final String chatRoomId;
  final String chatRoomName;
  final bool groupChat;
  final List<String> usersImage;
  static String routeName = '/chat/chat_room';

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('chatRoomId', chatRoomId));
    properties.add(StringProperty('chatRoomName', chatRoomName));
    properties.add(IterableProperty<String>('usersImage', usersImage));
    properties.add(DiagnosticsProperty<bool>('chatGroup', groupChat));
  }
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  MessageServiceFireStore dataServiceFireStore = MessageServiceFireStore();
  MessageServiceAlgolia dataServiceAlgolia = MessageServiceAlgolia();
  late UserModel thisUser = Provider.of<UserModel?>(context, listen: false)!;
  final TextEditingController newChatRoomNameController =
      TextEditingController();
  late List<String> otherUsersId = [];
  late List<String> usersImage = [];
  late String chatRoomName = '';

  Future<void> getOtherUsersId() async {
    var isEmpty = false;
    if (widget.usersImage.isNotEmpty && widget.chatRoomName.isNotEmpty) {
      setState(() {
        usersImage = widget.usersImage;
        chatRoomName = widget.chatRoomName;
      });
      isEmpty = true;
    }

    await dataServiceFireStore.getChatRoom(widget.chatRoomId).then((value) {
      final usersId = value.usersId;
      usersId.removeWhere((element) => element == thisUser.uid);
      setState(() {
        if (!isEmpty) {
          final mapData =
              UsersCard.getImagesAndChatRoomName(value, thisUser.uid);
          chatRoomName = mapData[chatRoomNameStr].toString();
          usersImage =
              (mapData[usersImageStr] as List<dynamic>).cast<String>().toList();
        }
        otherUsersId = usersId;
      });
    });
  }

  void changeGroupChatName() {
    if (widget.groupChat) {
      //chạy hàm change name group chat đây
      displayTextInputDialog(context);
    }
    //else ko chạy : ) ko cần thiết lắm
  }

  @override
  void initState() {
    super.initState();
    getOtherUsersId().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    chatRoomId: widget.chatRoomId,
                    groupChat: widget.groupChat,
                  );
                },
              );
            })
          ],
        ),
        body: Body(
          chatRoomId: widget.chatRoomId,
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
                  style: TextStyle(color: kTextColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  final newChatRoomName = newChatRoomNameController.text;
                  if (newChatRoomName != chatRoomName) {
                    dataServiceFireStore.changeGroupChatName(
                        widget.chatRoomId, newChatRoomNameController.text);
                    setState(() {
                      chatRoomName = newChatRoomNameController.text;
                    });
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: kPrimaryColor),
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
      BotToast.showAttachedWidget(
        attachedBuilder: (_) =>
            PersonalChatDialog(userId: otherUsersId[0], parentContext: context),
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
    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'dataService', dataServiceFireStore));
    properties.add(DiagnosticsProperty<UserModel>('thisUser', thisUser));
    properties.add(IterableProperty<String>('usersImage', usersImage));
    properties.add(StringProperty('chatRoomName', chatRoomName));
    properties.add(IterableProperty<String>('usersId', otherUsersId));
    properties.add(DiagnosticsProperty<MessageServiceAlgolia>(
        'dataServiceAlgolia', dataServiceAlgolia));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'newChatRoomNameController', newChatRoomNameController));
  }
}
