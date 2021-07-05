import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../providers/loading_overlay_provider.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../../../utils/helper/flash/flash_helper.dart';
import '../../../../utils/routes/routes.dart';
import '../../searching_screen/search_screen.dart';

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
    final _loadingOverlayProvider = context.read<LoadingOverlayProvider>();

    _loadingOverlayProvider.updateLoading(isLoading: true);

    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _categoryId = widget.categoryId;

    final _postCardsFromCategoryId =
        await _firestoreDatabase.getPostCardsByMainCategoryId(
      mainCategoryId: _categoryId,
    );

    final _itemsCount = _postCardsFromCategoryId.length;

    _loadingOverlayProvider.updateLoading(isLoading: false);

    if (_itemsCount == 0) {
      return FlashHelper.showDialogFlash(
        context,
        title: const Text('Danh mục này chưa có bài đăng nào'),
        content: const Text('Bạn hãy chọn danh mục khác nhé'),
        showBothAction: false,
      );
    }

    await Future.wait([
      // Increase view by 1
      _firestoreDatabase.increaseCategoryView(categoryId: _categoryId),
      // Update current user's category history
      _firestoreDatabase.updateCurrentUserCategoryHistory(
          categoryId: _categoryId),
      // Navigate to category kind screen
      _navigateToCategoryKindScreen(),
    ]);
  }

  Future<void> _navigateToCategoryKindScreen() async {
    return pushNewScreenWithRouteSettings<void>(
      context,
      screen: SearchScreen(
        cateId: widget.categoryId,
      ),
      settings: const RouteSettings(name: Routes.searchScreenRouteName),
      withNavBar: false,
    );
  }
}
