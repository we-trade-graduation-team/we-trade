import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/cloud_firestore/special_offer_card_models/my_special_offer_card/my_special_offer_card.dart';
import '../../../../models/cloud_firestore/special_offer_card_models/special_offer_card/special_offer_card.dart';
import '../../../../models/cloud_firestore/special_offer_card_models/user_special_offer_cards/user_special_offer_card.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import 'home_screen_special_offer_card.dart';

class HomeScreenSpecialOfferCards extends StatelessWidget {
  const HomeScreenSpecialOfferCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userSpecialOfferCards = context.watch<List<UserSpecialOfferCard>>();

    final _specialOfferCards = context.watch<List<SpecialOfferCard>>();

    final _cardHeight = context.watch<double>();

    final listToShow = _userSpecialOfferCards.isNotEmpty
        ? _userSpecialOfferCards
        : _specialOfferCards;

    return CustomAnimationLimiterForListView<MySpecialOfferCard>(
      scrollDirection: Axis.horizontal,
      separatorWidth: 15,
      duration: const Duration(
        milliseconds: AppDimens.kFlutterStaggeredAnimationsDuration * 2,
      ),
      addLastSeparator: true,
      list: listToShow,
      builder: (_, specialOfferCard) {
        return HomeScreenSpecialOfferCard(
          specialOfferCard: specialOfferCard,
          cardHeight: _cardHeight,
          press: () {},
        );
      },
    );
  }
}
