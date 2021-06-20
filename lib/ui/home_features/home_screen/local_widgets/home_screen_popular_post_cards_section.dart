import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';
import '../../../../models/ui/home_features/home_screen/section_title_row_model.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'home_screen_popular_post_cards.dart';
import 'home_screen_section_with_list_view_child.dart';

class HomeScreenPopularPostCardsSection extends StatelessWidget {
  const HomeScreenPopularPostCardsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _appLocalization = AppLocalizations.of(context);

    return HomeScreenSectionWithListViewChild(
      sectionColumnModel: SectionColumnModel(
        sectionTitleRowModel: SectionTitleRowModel(
          title:
              _appLocalization.translate('homeScreenTxtPopularPostCardsTitle'),
          press: () {},
        ),
        child: StreamProvider<List<PostCard>>.value(
          initialData: const [],
          value: _firestoreDatabase.popularPostCardsStream(),
          catchError: (_, __) => const [],
          child: const HomeScreenPopularPostCards(),
        ),
      ),
    );
  }
}
