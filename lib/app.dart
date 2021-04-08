import 'package:flutter/material.dart';

import 'configs/Theme/theme.dart';
import 'screens/other_user_profile/other_user_profile_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: OtherUserProfileScreen(),
    );
  }
}
