import 'package:flutter/widgets.dart';

import '../screens/shared_features/other_user_profile/other_user_profile_screen.dart';
import '../screens/shared_features/report/report_screen.dart';

final Map<String, WidgetBuilder> sharedFeaturesRoutes = {
  OtherUserProfileScreen.routeName: (_) => const OtherUserProfileScreen(),
  ReportScreen.routeName: (_) => const ReportScreen(),
};
