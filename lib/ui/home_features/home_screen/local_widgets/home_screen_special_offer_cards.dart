import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../constants/app_dimens.dart';
import '../../../../models/cloud_firestore/special_offer_card/special_offer_card.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';
import '../../../../models/ui/home_features/home_screen/section_title_row_model.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import 'home_screen_special_offer_card.dart';
import 'home_section_with_list_view_child.dart';

class HomeScreenSpecialOfferCards extends StatelessWidget {
  const HomeScreenSpecialOfferCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _appLocalization = AppLocalizations.of(context);

    final size = MediaQuery.of(context).size;

    final cardHeight = size.height * 0.123;

    return HomeSectionWithListViewChild(
      sectionColumnModel: SectionColumnModel(
        sectionTitleRowModel: SectionTitleRowModel(
          title:
              _appLocalization.translate('homeScreenTxtSpecialOfferCardsTitle'),
          press: () {},
        ),
        child: SizedBox(
          height: cardHeight,
          child: StreamProvider<List<SpecialOfferCard>>.value(
            value: _firestoreDatabase.userSpecialOfferCardsStream(),
            initialData: const [],
            child: Consumer<List<SpecialOfferCard>>(
              builder: (_, specialOfferCards, __) {
                return CustomAnimationLimiterForListView<SpecialOfferCard>(
                  scrollDirection: Axis.horizontal,
                  separatorWidth: 15,
                  duration: const Duration(
                    milliseconds:
                        AppDimens.kFlutterStaggeredAnimationsDuration * 2,
                  ),
                  addLastSeparator: true,
                  list: specialOfferCards,
                  builder: (_, specialOfferCard) {
                    return HomeScreenSpecialOfferCard(
                      specialOfferCard: specialOfferCard,
                      cardHeight: cardHeight,
                      press: () {},
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
