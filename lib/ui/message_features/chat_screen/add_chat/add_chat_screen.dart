import 'package:flutter/material.dart';
import 'body.dart';

class AddChatScreen extends StatelessWidget {
  const AddChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD CHAT'),
      ),
      body: const Body(),
    );
  }
}
