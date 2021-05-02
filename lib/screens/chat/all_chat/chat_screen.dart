import 'package:flutter/material.dart';

import '../../../configs/constants/color.dart';
// import '../../../widgets/custom_bottom_navigation_bar.dart';
import 'body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // final int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CHAT',
        ),
      ),
      body: const Body(),
      // Container(
      //   margin: const EdgeInsets.all(20),
      //   child: ButtonWidget(
      //     press: (){},
      //     text: 'Active',
      //     isFilled: false,
      //     width: 100,
      //     ),
      // ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   selectedIndex: _selectedIndex,
      // ),
      floatingActionButton: const BuildFloatingActionButton(),
    );
  }
}

class BuildFloatingActionButton extends StatelessWidget {
  const BuildFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      // => Navigator.pushNamed(
      //   context, ),
      backgroundColor: kPrimaryColor,
      child: const Icon(
        Icons.group_add,
        color: Colors.white,
      ),
    );
  }
}
