import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/post_card_models/post_card/post_card.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';
import '../../../../models/ui/home_features/home_screen/section_title_row_model.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../shared_widgets/horizontal_scroll_post_card_list_view.dart';
import 'home_screen_section_with_list_view_child.dart';

class HomeScreenPopularPostCards extends StatelessWidget {
  const HomeScreenPopularPostCards({
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
          child: Consumer<List<PostCard>>(
            builder: (_, postCards, __) {
              return HorizontalScrollPostCardListView(
                postCards: postCards,
              );
            },
          ),
        ),
      ),
    );
  }
}
