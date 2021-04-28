import 'package:flutter/material.dart';

import '../../configs/constants/color.dart';
import '../account/account_screen.dart';

// ignore: use_key_in_widget_constructors
class FollowScreen extends StatelessWidget {
  static const routeName = '/follow';
  
  @override
  Widget build(BuildContext context) {
    final screen = ModalRoute.of(context)!.settings.arguments as Follow_Screen;
    return Scaffold(
      appBar: AppBar(
        title: screen == Follow_Screen.Follower
            ? const Text('Theo dõi bởi')
            : const Text('Theo  dõi'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Image.asset(
                'assets/images/Chat_screen_ava_temp/user.png',
                height: 60,
                fit: BoxFit.cover,
              ),
              title: const Text('Duy Quang'),
              trailing: index == 0
                  ? OutlinedButton(
                      onPressed: () {
                      
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: const Text(
                        'Bỏ theo dõi',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        elevation: 4,
                        onPrimary: kPrimaryLightColor,
                      ),
                      child: const Text('   Theo dõi  '),
                    ),
            ),
          ),
          itemCount: 2,
        ),
      ),
    );
  }
}
