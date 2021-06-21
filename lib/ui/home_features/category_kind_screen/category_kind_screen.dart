import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../providers/loading_overlay_provider.dart';
import '../../../services/firestore/firestore_database.dart';
import '../../../utils/routes/routes.dart';
import '../home_screen/local_widgets/home_screen_icon_button_with_counter.dart';
import '../home_screen/local_widgets/home_screen_search_bar.dart';
import '../notification_screen/notification_screen.dart';
// import '../searching_screen/local_widgets/filter_overlay.dart';
import 'local_widgets/category_post_card.dart';

// Flash Deal is deleted
// const productKind = ProductKind(name: 'Laptop');

class CategoryKindScreen extends StatelessWidget {
  const CategoryKindScreen({
    Key? key,
    required this.mainCategoryId,
  }) : super(key: key);

  final String mainCategoryId;

  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.watch<FirestoreDatabase>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.05,
                ),
                Container(
                  width: size.width * 0.75,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const HomeScreenSearchBar(),
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: HomeScreenIconButtonWithCounter(
                      iconColor: Colors.grey,
                      icon: 'bell',
                      numOfItems: 4,
                      press: () => pushNewScreenWithRouteSettings<void>(
                        context,
                        screen: const NotificationScreen(),
                        settings: const RouteSettings(
                            name: Routes.notificationScreenRouteName),
                        withNavBar: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ChangeNotifierProvider<LoadingOverlayProvider>(
        create: (_) => LoadingOverlayProvider(),
        child: Consumer<LoadingOverlayProvider>(
          builder: (_, loadingOverlay, __) {
            return LoadingOverlay(
              isLoading: loadingOverlay.isLoading,
              color: Colors.white,
              opacity: 1,
              progressIndicator: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              child: LayoutBuilder(
                builder: (context, viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.center
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: size.width * 0.05),
                            FutureProvider<List<PostCard>?>.value(
                              initialData: null,
                              value: _firestoreDatabase
                                  .getPostCardsByMainCategoryId(
                                mainCategoryId: mainCategoryId,
                              ),
                              catchError: (_, __) => const [],
                              child: const CategoryPostCard(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('mainCategory', mainCategoryId));
  }
}
