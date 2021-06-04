import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../utils/routes/routes.dart';
import '../home_screen/local_widgets/home_screen_icon_button_with_counter.dart';
import '../home_screen/local_widgets/home_screen_search_bar.dart';
import '../notification_screen/notification_screen.dart';
import '../searching_screen/local_widgets/filter_overlay.dart';

const productKind = ProductKind(name: 'Flash Deal');

class CategoryKindScreen extends StatelessWidget {
  const CategoryKindScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: LayoutBuilder(builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    /*child: SectionTitle(
                            title: 'Sản phẩm mới',
                            press: () {},
                          ),*/
                  ),
                  SizedBox(height: size.width * 0.05),
                  // TODO: <Vu> Replace List<Product> with List<PostCard> (wrap below StreamBuilder)
                  // HorizontalScrollPostCardListView(postCards: demoProducts),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    // child: SectionTitle(
                    //   title: productKind.name,
                    //   press: () {},
                    // ),
                  ),
                  SizedBox(height: size.width * 0.05),

                  /// TODO: <Vu> Replace GridView Widget with Wrap Widget to show list of post card
                  /// (see example at home_screen/local_widgets/home_screen_recommended_section.dart)
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.05),
                    child: GridView.count(
                      childAspectRatio: size.height / 1090,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      crossAxisCount: 2,
                      //padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      crossAxisSpacing: size.width * 0.05,
                      mainAxisSpacing: size.height * 0.01,
                      // TODO: <Vu> Replace Product with PostCard
                      // children: [
                      //   ...List.generate(
                      //     recommendedProducts.length,
                      //     (index) => ItemPostCard(
                      //         postCard: recommendedProducts[index]),
                      //   ),
                      // ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
