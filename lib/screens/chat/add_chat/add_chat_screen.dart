import 'package:flutter/material.dart';
import 'body.dart';

class AddChatScreen extends StatefulWidget {
  const AddChatScreen({Key? key}) : super(key: key);
  static String routeName = '/chat/add_chat';
  @override
  _AddChatScreenState createState() => _AddChatScreenState();
}

class _AddChatScreenState extends State<AddChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD CHAT',
        ),
      ),
      body: const Body(),
    );
  }
}
