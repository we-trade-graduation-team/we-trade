import 'package:flutter/material.dart';
import 'body.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);
  static String routeName = '/chat/add_chat';

  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SearchUserScreenArgument;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            args.tittle,
          ),
        ),
        body: Body(
          chatRoomId: args.chatRoomId,
          addChat: args.addChat,
          usersId: args.usersId,
        ),
      ),
    );
  }
}

class SearchUserScreenArgument {
  SearchUserScreenArgument({
    this.chatRoomId = '',
    required this.tittle,
    required this.addChat,
    required this.usersId,
  });
  final String tittle;
  final bool addChat;
  final List<String> usersId;
  final String chatRoomId;
}
