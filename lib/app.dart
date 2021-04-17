// import 'package:flutter/material.dart';
// import 'package:we_trade/screens/category/category.dart';
// import 'package:we_trade/screens/notification/notification_screen.dart';
// import 'package:we_trade/screens/report/build_report_screen.dart';
// import 'package:we_trade/screens/report/report_screen.dart';

// import 'configs/constants/routes.dart';
// import 'configs/constants/strings.dart';
// import 'configs/theme/theme.dart';
// import 'screens/onboarding/onboarding.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: kAppTitle,
//       theme: theme(),
//       initialRoute: BuildReportScreen.routeName,
//       routes: routes,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:we_trade/screens/chat/dialogs/group_chat_dialog.dart';
import 'package:we_trade/screens/detail/local_widgets/popup_dialog.dart';

import 'configs/Theme/theme.dart';
import 'screens/chat/dialogs/chat_dialog.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        //home: OtherUserProfileScreen(),
        home: Scaffold(
          appBar: AppBar(
            title: Text('temp'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: PopupDialog(),
          ),
        ));
  }
}
