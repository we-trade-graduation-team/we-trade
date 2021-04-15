import 'package:flutter/material.dart';

import '../../../models/chat/temp_class.dart';
import '../../../widgets/buttons.dart';
import '../widgets/chat_card_choose_new.dart';
import '../widgets/search_bar.dart';

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
              itemCount: usersData.length,
              itemBuilder: (context, index) => ChatCardAddNew(
                user: usersData[index],
                press: (){}, 
                isSelected: false,
                ),
              ),
          ),
          ButtonWidget(press: (){}, text: 'OK', width: MediaQuery.of(context).size.width-40, height: 30,)
        ],
      ),
    );
  }
}