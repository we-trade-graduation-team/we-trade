import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:we_trade/ui/home_features/category_kind_screen/category_kind_screen.dart';
import 'package:we_trade/utils/routes/routes.dart';

import '../../../../services/firestore/firestore_database.dart';
// import '../../../../utils/routes/routes.dart';
// import '../../category_kind_screen/category_kind_screen.dart';

class HomeScreenCategoryCardFundamental extends StatefulWidget {
  const HomeScreenCategoryCardFundamental({
    Key? key,
    required this.child,
    required this.categoryId,
  }) : super(key: key);

  final Widget child;
  final String categoryId;

  @override
  _HomeScreenCategoryCardFundamentalState createState() =>
      _HomeScreenCategoryCardFundamentalState(categoryId: categoryId);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('categoryId', categoryId));
  }
}

class _HomeScreenCategoryCardFundamentalState
    extends State<HomeScreenCategoryCardFundamental> {

  _HomeScreenCategoryCardFundamentalState({required this.categoryId});
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }

  Future<void> _onTap() async {
    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _categoryId = widget.categoryId;

    await Future.wait([
      // Increase view by 1
      _firestoreDatabase.increaseCategoryView(categoryId: _categoryId),
      // Update current user's category history
      _firestoreDatabase.updateCurrentUserCategoryHistory(
          categoryId: _categoryId),
      // // Navigate to category kind screen
      _navigateToCategoryKindScreen(),
    ]);
  }

  // TODO: <Vu> Fix this Screen
  Future<void> _navigateToCategoryKindScreen() async {
    return pushNewScreenWithRouteSettings<void>(
      context,
      screen: CategoryKindScreen(mainCategory: categoryId,),
      settings: const RouteSettings(
        name: Routes.categoryKindScreenRouteName,
      ),
      withNavBar: true,
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('categoryId', categoryId));
  }
}
