import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../configs/constants/color.dart';
import '../../../../models/authentication/user_model.dart';
import '../search_user/search_user_screen.dart';
import 'body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'CHAT',
          ),
          //TODO làm tạm để load lại all chat room
          //mốt xóa đi : ) ===> real time
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
                    builder: (context) => super.widget));
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: const Icon(
                  Icons.replay,
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
        ),
        body: const Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final thisUser = Provider.of<UserModel?>(context, listen: false)!;
            pushNewScreenWithRouteSettings<void>(
              context,
              screen: const SearchUserScreen(),
              settings: RouteSettings(
                name: SearchUserScreen.routeName,
                arguments: SearchUserScreenArgument(
                    tittle: 'ADD CHAT', addChat: true, usersId: [thisUser.uid]),
              ),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
