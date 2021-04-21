import 'package:flutter/material.dart';
import '../../../../models/chat/temp_class.dart';
import '../../widgets/user_card.dart';

class AllMemberScreen extends StatelessWidget {
  const AllMemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'THÀNH VIÊN',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Expanded(
          child: ListView.builder(
            itemCount: usersData.length,
            itemBuilder: (context, index) => UserCard(
                user: usersData[index], press: () {}, showActiveAt: false),
          ),
        ),
      ),
    );
  }
}
