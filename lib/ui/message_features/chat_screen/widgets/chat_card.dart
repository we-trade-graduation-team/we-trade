import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../models/ui/chat/temp_class.dart';
import '../../../../services/message/algolia_user_service.dart';
import '../../../../widgets/custom_user_avatar.dart';
import '../../const_string/const_str.dart';
import '../../helper/ulti.dart';
import '../chat_room/chat_room.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({
    Key? key,
    required this.chat,
    this.isActive = false,
    required this.doc,
    required this.typeFunction,
    required this.thisUserId,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> doc;
  final Chat chat;
  final bool isActive;
  final String typeFunction, thisUserId;

  @override
  _ChatCardState createState() => _ChatCardState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Chat>('chat', chat));
    properties.add(DiagnosticsProperty<bool>('isActive', isActive));
    properties.add(StringProperty('typeFunction', typeFunction));
    properties
        .add(DiagnosticsProperty<QueryDocumentSnapshot<Object?>>('doc', doc));
    properties.add(StringProperty('thisUserId', thisUserId));
  }
}

class _ChatCardState extends State<ChatCard> {
  UserServiceAlgolia userServiceAlgolia = UserServiceAlgolia();
  late List<String> images = [];
  late String chatRoomName = '';
  late bool isSeen = false;
  late bool isSendByMe = false;

  Widget buildChatRoomImage() {
    if (images.isNotEmpty) {
      if (!widget.chat.groupChat) {
        return Stack(
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
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
          ],
        );
      } else {
        return Container(
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
                  child: CustomUserAvatar(image: images[1], radius: 16 - 2),
                ),
              ),
            ],
          ),
        );
      }
    }
    return Container();
  }

  String getLastMessage() {
    final name = isSendByMe
        ? 'Bạn:'
        : (widget.chat.senderName.isNotEmpty
            ? '${widget.chat.senderName}:'
            : '');
    return '$name ${widget.chat.lastMessage}';
  }

  Future<bool> getIsSeen() {
    var myLastMessageId = '';
    return widget.doc.reference
        .collection(seenHistoryCollection)
        .doc(widget.chat.chatRoomId)
        .get()
        .then((value) {
      myLastMessageId = value.data()![widget.thisUserId].toString();
      return myLastMessageId == widget.chat.lastMessageId;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getIsSeen().then((value) {
      setState(() {
        isSeen = value;
      });
    });
    setState(() {
      isSendByMe = widget.chat.senderId == widget.thisUserId;
    });
    final imagesAndChatRoomName =
        HelperClass.getImagesAndChatRoomName(widget.chat, widget.thisUserId);
    images = (imagesAndChatRoomName[imagesStr] as List<dynamic>)
        .cast<String>()
        .toList();
    chatRoomName = imagesAndChatRoomName[chatRoomNameStr].toString();
    return images.isNotEmpty
        ? InkWell(
            onTap: () {
              if (widget.typeFunction == navigateToChatRoomStr) {
                pushNewScreenWithRouteSettings<void>(
                  context,
                  settings: RouteSettings(
                    name: ChatRoomScreen.routeName,
                  ),
                  screen: ChatRoomScreen(
                    chat: widget.chat,
                    chatRoomName: chatRoomName,
                    usersImage: images,
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  buildChatRoomImage(),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatRoomName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  !isSeen ? FontWeight.bold : FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Opacity(
                                opacity: 0.64,
                                child: Text(
                                  getLastMessage(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: !isSeen
                                      ? const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)
                                      : const TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Opacity(
                              opacity: 0.64,
                              child: Text(
                                widget.chat.time,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: !isSeen
                                        ? FontWeight.bold
                                        : FontWeight.normal),
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
    properties.add(DiagnosticsProperty<bool>('isActive', widget.isActive));
    properties.add(IterableProperty<String>('images', images));
    properties.add(StringProperty('chatRoomName', chatRoomName));
    properties.add(DiagnosticsProperty<UserServiceAlgolia>(
        'userServiceAlgolia', userServiceAlgolia));
    properties.add(DiagnosticsProperty<bool>('isSeen', isSeen));
    properties.add(DiagnosticsProperty<bool>('isSendByMe', isSendByMe));
  }
}
