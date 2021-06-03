import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/cloud_firestore/category_card/category_card.dart';
import '../../../../utils/routes/routes.dart';
import '../../category_kind_screen/category_kind_screen.dart';

class HomeScreenCategoryCard extends StatelessWidget {
  const HomeScreenCategoryCard({
    Key? key,
    required this.categoryCard,
    // required this.press,
  }) : super(key: key);

  final CategoryCard categoryCard;
  // final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    // print(WordCount().countWords(text));
    final size = MediaQuery.of(context).size;
    final cardSize = size.height * 0.09;
    return GestureDetector(
      onTap: () => pushNewScreenWithRouteSettings<void>(
        context,
        screen: const CategoryKindScreen(),
        settings: const RouteSettings(
          name: Routes.categoryKindScreenRouteName,
        ),
        withNavBar: true,
      ),
      child: Container(
        // color: Colors.blue,
        width: cardSize,
        height: cardSize,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                // height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LayoutBuilder(
                    builder: (_, constraint) => Icon(
                      LineIcons.values[categoryCard.iconKey],
                      size: constraint.biggest.height / 1.5,
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 2),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  categoryCard.category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.kTextLightColor,
                    fontSize: 11,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<CategoryCard>('categoryCard', categoryCard));
  }
}
