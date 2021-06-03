import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

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
    this.chatRoomName = '',
    this.usersImage = const [],
  }) : super(key: key);

  final String chatRoomId;
  final String chatRoomName;
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
  }
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  MessageServiceFireStore dataServiceFireStore = MessageServiceFireStore();
  MessageServiceAlgolia dataServiceAlgolia = MessageServiceAlgolia();
  late UserModel thisUser = Provider.of<UserModel?>(context, listen: false)!;

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
    await dataServiceAlgolia
        .getImagesAndChatRoomNameAndOtherUsersId(
            widget.chatRoomId, thisUser.uid)
        .then((mapData) {
      setState(() {
        if (!isEmpty) {
          chatRoomName = mapData[chatRoomNameStr].toString();
          usersImage =
              (mapData[usersImageStr] as List<dynamic>).cast<String>().toList();
        }
        otherUsersId =
            (mapData[usersIdStr] as List<dynamic>).cast<String>().toList();
      });
    });
  }

  void changeGroupChatName() {
    if (otherUsersId.length != 1) {
      //TODO chạy hàm change name group chat đây
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
    return Scaffold(
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
                  type: otherUsersId.length == 1,
                );
              },
            );
          })
        ],
      ),
      body: Body(
        chatRoomId: widget.chatRoomId,
      ),
    );
  }

  Future<void> showOverlay(
      {required BuildContext context,
      required bool type,
      required String chatRoomId}) async {
    if (type) {
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
  }
}
