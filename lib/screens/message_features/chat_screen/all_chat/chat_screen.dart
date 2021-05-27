import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../configs/constants/color.dart';
import '../add_chat/add_chat_screen.dart';
import 'body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'CHAT',
        ),
        //TODO làm tạm để load lại all chat room
        //mốt xóa đi : ) ===> real time
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => this));
              log('?????');
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: const Icon(
                Icons.replay,
                color: kPrimaryColor,
              ),
            ),
          )
        ],
      ),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pushNewScreen<void>(
          context,
          screen: const AddChatScreen(),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ),
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.group_add,
          color: Colors.white,
        ),
      ),
    );
  }
}
