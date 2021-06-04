import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/special_offer_card_models/special_offer_card/special_offer_card.dart';
import '../../../../models/cloud_firestore/special_offer_card_models/user_special_offer_cards/user_special_offer_card.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';
import '../../../../models/ui/home_features/home_screen/section_title_row_model.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'home_screen_section_with_list_view_child.dart';
import 'home_screen_special_offer_cards.dart';

class HomeScreenSpecialOfferCardsSection extends StatefulWidget {
  const HomeScreenSpecialOfferCardsSection({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenSpecialOfferCardsSectionState createState() =>
      _HomeScreenSpecialOfferCardsSectionState();
}

class _HomeScreenSpecialOfferCardsSectionState
    extends State<HomeScreenSpecialOfferCardsSection> {
  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _appLocalization = AppLocalizations.of(context);

    final _size = MediaQuery.of(context).size;

    final _cardHeight = _size.height * 0.123;

    return HomeScreenSectionWithListViewChild(
      sectionColumnModel: SectionColumnModel(
        sectionTitleRowModel: SectionTitleRowModel(
          title:
              _appLocalization.translate('homeScreenTxtSpecialOfferCardsTitle'),
          press: () {},
        ),
        child: SizedBox(
          height: _cardHeight,
          child: MultiProvider(
            providers: [
              StreamProvider<List<UserSpecialOfferCard>>.value(
                value: _firestoreDatabase.userSpecialOfferCardsStream(),
                initialData: const [],
              ),
              StreamProvider<List<SpecialOfferCard>>.value(
                value: _firestoreDatabase.specialOfferCardsStream(),
                initialData: const [],
              ),
              Provider<double>.value(value: _cardHeight),
            ],
            child: const HomeScreenSpecialOfferCards(),
          ),
        ),
      ),
    );
  }
}
