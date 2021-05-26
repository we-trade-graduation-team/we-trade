import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/authentication/user_model.dart';

import '../../../../models/chat/temp_class.dart';
import '../../../../widgets/custom_user_avatar.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({
    Key? key,
    required this.chat,
    required this.press,
    this.isActive = false,
    this.isSendByMe = false,
  }) : super(key: key);

  final Chat chat;
  final bool isSendByMe;
  final bool isActive;
  final VoidCallback press;

  @override
  _ChatCardState createState() => _ChatCardState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isSendByMe', isSendByMe));
    properties.add(DiagnosticsProperty<Chat>('chat', chat));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(DiagnosticsProperty<bool>('isActive', isActive));
  }
}

class _ChatCardState extends State<ChatCard> {
  late UserModel thisUser = Provider.of<UserModel?>(context, listen: false)!;
  late List<String> images = <String>['', ''];
  late String chatRoomName = '';

  Future<void> getImagesAndChatRoomName() async {
    Future.delayed(const Duration(), () async {
      if (widget.chat.usersId.length == 2) {
        var otherUserIndex = 0;
        for (var i = 0; i < 2; i++) {
          if (widget.chat.usersId[i] != thisUser.uid) {
            otherUserIndex = i;
            break;
          }
        }
        setState(() {
          images = [widget.chat.images[otherUserIndex]];
          chatRoomName = widget.chat.names[otherUserIndex];
        });
      } else {
        setState(() {
          images = widget.chat.images;
          chatRoomName = widget.chat.chatRoomName;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getImagesAndChatRoomName().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return images.isNotEmpty
        ? InkWell(
            onTap: widget.press,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  if (widget.chat.usersId.length == 2)
                    Stack(
                      children: [
                        CustomUserAvatar(image: images[0], radius: 24),
                        if (widget.isActive)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                              ),
                            ),
                          ),
                      ],
                    )
                  else
                    Container(
                      width: 48,
                      height: 48,
                      child: Stack(
                        children: [
                          CustomUserAvatar(image: images[0], radius: 16),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: CustomUserAvatar(
                                  image: images[1], radius: 16 - 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //tODO fix name here
                          chatRoomName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Opacity(
                                opacity: 0.64,
                                child: Text(
                                  '${widget.isSendByMe ? "Bạn" : widget.chat.senderName}: ${widget.chat.lastMessage}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Opacity(
                              opacity: 0.64,
                              child: Text(
                                widget.chat.time,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Chat>('chat', widget.chat));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', widget.press));
    properties.add(DiagnosticsProperty<bool>('isActive', widget.isActive));
    properties.add(DiagnosticsProperty<bool>('isSendByMe', widget.isSendByMe));
    properties.add(DiagnosticsProperty<UserModel>('thisUser', thisUser));
    properties.add(IterableProperty<String>('images', images));
    properties.add(StringProperty('chatRoomName', chatRoomName));
  }
}
