import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/cloud_firestore/special_category_card/special_category_card.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import '../../../../widgets/shared_circular_progress_indicator.dart';
import 'home_screen_special_category_card.dart';

class HomeScreenSpecialCategoryCards extends StatelessWidget {
  const HomeScreenSpecialCategoryCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _specialOfferCards = context.watch<List<SpecialCategoryCard>?>();

    if (_specialOfferCards == null) {
      return const SharedCircularProgressIndicator();
    }

    final _cardHeight = context.watch<double>();

    return CustomAnimationLimiterForListView<SpecialCategoryCard>(
      scrollDirection: Axis.horizontal,
      separatorWidth: 15,
      duration: const Duration(
        milliseconds: AppDimens.kFlutterStaggeredAnimationsDuration * 2,
      ),
      addLastSeparator: true,
      list: _specialOfferCards,
      builder: (_, specialOfferCard) {
        return HomeScreenSpecialCategoryCard(
          specialCategoryCard: specialOfferCard,
          cardHeight: _cardHeight,
        );
      },
    );
  }
}
