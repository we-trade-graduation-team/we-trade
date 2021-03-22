import 'package:flutter/material.dart';
import 'package:we_trade/screens/chat/add_chat/add_chat_screen.dart';

import 'configs/Theme/Theme.dart';
import 'screens/chat/all_chat/chat_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: const AddChatScreen(),
    );
  }
}
