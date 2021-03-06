import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/cloud_firestore/category_card/category_card.dart';
import 'home_screen_category_card_fundamental.dart';

class HomeScreenCategoryCard extends StatelessWidget {
  const HomeScreenCategoryCard({
    Key? key,
    required this.categoryCard,
  }) : super(key: key);

  final CategoryCard categoryCard;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final _cardSize = _size.height * 0.09;

    return HomeScreenCategoryCardFundamental(
      categoryId: categoryCard.categoryId!,
      child: Container(
        width: _cardSize,
        height: _cardSize,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
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
