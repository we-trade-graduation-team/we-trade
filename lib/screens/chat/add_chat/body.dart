import 'package:flutter/material.dart';

import '../../../models/chat/chat.dart';
import '../../../widgets/buttons.dart';
import '../components/chat_card_choose_new.dart';
import '../components/search_bar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const SearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCardAddNew(
                chat: chatsData[index],
                press: () {},
                // isSelected: false,
              ),
            ),
          ),
          ButtonWidget(
              press: () {},
              text: 'OK',
              width: MediaQuery.of(context).size.width - 40),
        ],
      ),
    );
  }
}
