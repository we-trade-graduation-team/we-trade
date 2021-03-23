import 'package:flutter/material.dart';

import 'configs/Theme/theme.dart';
import 'screens/chat/add_chat/add_chat_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: const AddChatScreen(),
    );
  }
}
