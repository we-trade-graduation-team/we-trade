import 'package:flutter/material.dart';

import '../../../models/chat/temp_class.dart';
import '../widgets/chat_card.dart';
import '../widgets/search_bar.dart';

class Body extends StatelessWidget {

  
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const SearchBar(),
          Expanded(
            // child: Text('hello'),
             child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                chat: chatsData[index],
                press: (){},
                // press: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MessagesScreen(),
                //   ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}


