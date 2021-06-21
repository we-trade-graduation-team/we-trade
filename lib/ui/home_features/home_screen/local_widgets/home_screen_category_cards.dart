import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';
import '../../../../constants/app_dimens.dart';
import '../../../../models/cloud_firestore/category_card/category_card.dart';

import 'home_screen_category_card.dart';

class HomeScreenCategoryCards extends StatelessWidget {
  const HomeScreenCategoryCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _categoryCards = context.watch<List<CategoryCard>>();

    final _categoryCardsLength = _categoryCards.length;

    const _numberOfCardsEachPage =
        AppDimens.kHomeScreenCategoryCardsEachPageAmount;

    final _itemCount = (_categoryCardsLength / _numberOfCardsEachPage).ceil();

    final categoryCards = List<List<CategoryCard>>.from(
        partition(_categoryCards, _numberOfCardsEachPage));

    return Swiper(
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Center(
            child: Wrap(
              spacing: 5,
              runSpacing: 15,
              children: categoryCards[index]
                  .map(
                    (categoryCard) =>
                        HomeScreenCategoryCard(categoryCard: categoryCard),
                  )
                  .toList(),
            ),
          ),
        );
      },
      pagination: const SwiperPagination(
        margin: EdgeInsets.all(5),
      ),
      itemCount: _itemCount,
    );
  }
}
