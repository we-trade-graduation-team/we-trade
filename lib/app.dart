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
import 'package:we_trade/models/product_model.dart';
import 'package:we_trade/screens/chat/dialogs/group_chat_dialog.dart';
import 'package:we_trade/screens/chat/personal_chat/personal_chat_screen.dart';
import 'package:we_trade/screens/detail/local_widgets/popup_dialog.dart';
import 'package:we_trade/screens/offer_screens/make_offer_screen.dart';
import 'package:we_trade/screens/offer_screens/offer_detail_screen.dart';
import 'package:we_trade/screens/other_user_profile/other_user_profile_screen.dart';

import 'configs/Theme/theme.dart';
import 'models/chat/temp_class.dart';
import 'screens/chat/dialogs/chat_dialog.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var offerSideProducts = [allProduct[0], allProduct[1]];
    var money = 100000;
    var forProduct = allProduct[3];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: OfferDetailScreen(
          forProduct: forProduct,
          isOfferSide: false,
          offerSideProducts: offerSideProducts,
          offerSideMoney: money),
      //home: OtherUserProfileScreen(),
      //home: PersonalChatScreen(userA: usersData[1], userB: usersData[1]),
    );
  }
}
