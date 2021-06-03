import 'package:flutter/material.dart';

class FollowScreen extends StatelessWidget {
  const FollowScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen =
        ModalRoute.of(context)!.settings.arguments as FollowScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: screen.screenName == Follow_Screen_Name.follower
            ? const Text('Theo dõi bởi')
            : const Text('Theo  dõi'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: Image.asset(
              'assets/images/chat_screen_ava/user.png',
              height: 60,
              fit: BoxFit.cover,
            ),
            title: const Text('Duy Quang'),
            trailing: index == 0
                ? OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: const Text(
                      'Bỏ theo dõi',
                      // style: TextStyle(
                      //   color: Theme.of(context).primaryColor,
                      // ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      // primary: Theme.of(context).primaryColor,
                      elevation: 4,
                      // onPrimary: Theme.of(context).primaryColorLight,
                    ),
                    child: const Text('Theo dõi'),
                  ),
          ),
        ),
        itemCount: 2,
      ),
    );
  }
}

enum Follow_Screen_Name {
  following,
  follower,
}

class FollowScreenArguments {
  FollowScreenArguments({required this.screenName});
  final Follow_Screen_Name screenName;
}
