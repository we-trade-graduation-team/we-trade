import 'package:flutter/material.dart';

import '../../../../models/ui/chat/temp_class.dart';
import '../../../../widgets/custom_material_button.dart';
import '../widgets/chat_card_choose_new.dart';
import '../widgets/search_bar.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

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
                press: () {
                  //
                },
                isSelected: false,
              ),
            ),
          ),
          CustomMaterialButton(
            press: () {
              //Navigator.pop(context);
              //tùy theo add nhiu ng mà chuyển hướng qua chat cá nhân/chat group
            },
            text: 'OK',
            width: MediaQuery.of(context).size.width - 100,
            height: 30,
          )
        ],
      ),
    );
  }
}
