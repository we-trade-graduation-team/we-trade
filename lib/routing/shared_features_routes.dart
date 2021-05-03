import 'package:flutter/widgets.dart';
import '../../screens/shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../screens/shared_features/report/build_report_screen.dart';

final Map<String, WidgetBuilder> sharedFeaturesRoutes = {
  OtherUserProfileScreen.routeName: (_) => const OtherUserProfileScreen(),
  BuildReportScreen.routeName: (_) => const BuildReportScreen(),
};
