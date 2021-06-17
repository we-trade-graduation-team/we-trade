import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

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
      _HomeScreenCategoryCardFundamentalState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('categoryId', categoryId));
  }
}

class _HomeScreenCategoryCardFundamentalState
    extends State<HomeScreenCategoryCardFundamental> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }

  Future<void> _onTap() async {
    await Future.wait([
      // Increase view by 1
      _viewIncrement(),
      // Update current user's category history
      _updateCurrentUserCategoryHistory(),
      // // Navigate to category kind screen
      // _navigateToCategoryKindScreen(),
    ]);
  }

  Future<void> _viewIncrement() async {
    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _categoryId = widget.categoryId;

    await _firestoreDatabase.increaseCategoryView(
      categoryId: _categoryId,
    );
  }

  Future<void> _updateCurrentUserCategoryHistory() async {
    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _categoryId = widget.categoryId;

    await _firestoreDatabase.updateUserCategoryHistory(
      categoryId: _categoryId,
    );
  }

  // TODO: <Vu> Fix this Screen
  // Future<void> _navigateToCategoryKindScreen() async {
  //   await pushNewScreenWithRouteSettings<void>(
  //     context,
  //     screen: const CategoryKindScreen(),
  //     settings: const RouteSettings(
  //       name: Routes.categoryKindScreenRouteName,
  //     ),
  //     withNavBar: true,
  //   );
  // }
}
