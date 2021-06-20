import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/special_category_card/special_category_card.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';
import '../../../../models/ui/home_features/home_screen/section_title_row_model.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'home_screen_section_with_list_view_child.dart';
import 'home_screen_special_category_cards.dart';

class HomeScreenSpecialCategoryCardsSection extends StatelessWidget {
  const HomeScreenSpecialCategoryCardsSection({
    Key? key,
  }) : super(key: key);

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
              _appLocalization.translate('homeScreenTxtSpecialCategoryCardsTitle'),
          press: () {},
        ),
        child: SizedBox(
          height: _cardHeight,
          child: MultiProvider(
            providers: [
              FutureProvider<List<SpecialCategoryCard>>.value(
                value: _firestoreDatabase.getHomeScreenSpecialCategoryCards(),
                initialData: const [],
                catchError: (_, __) => const [],
              ),
              Provider<double>.value(value: _cardHeight),
            ],
            child: const HomeScreenSpecialCategoryCards(),
          ),
        ),
      ),
    );
  }
}
