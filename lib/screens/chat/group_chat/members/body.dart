import 'package:flutter/material.dart';

import '../../../../models/chat/temp_class.dart';
import '../../widgets/user_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Expanded(
        child: ListView.builder(
          itemCount: usersData.length,
          itemBuilder: (context, index) => UserCard(
              user: usersData[index], press: () {}, showActiveAt: false),
        ),
      ),
    );
  }
}
