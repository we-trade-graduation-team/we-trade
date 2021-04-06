import 'package:flutter/material.dart';
import 'package:we_trade/configs/constants/color.dart';

class FollowingScreen extends StatelessWidget {
  static const routeName = '/following';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theo dõi'),
      ),
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
                        print('Bo theo doi button pressed');
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
                        print('theo doi pressed');
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
