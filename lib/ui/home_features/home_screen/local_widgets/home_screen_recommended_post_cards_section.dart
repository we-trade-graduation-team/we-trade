import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/post_card_models/post_card/post_card.dart';
import '../../../../models/cloud_firestore/post_card_models/user_recommended_post_card/user_recommended_post_card.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';
import '../../../../models/ui/home_features/home_screen/section_title_row_model.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'home_screen_recommended_post_cards.dart';
import 'home_screen_section_column.dart';

class HomeScreenRecommendedSection extends StatelessWidget {
  const HomeScreenRecommendedSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _appLocalization = AppLocalizations.of(context);

    return HomeScreenSectionColumn(
      sectionColumnModel: SectionColumnModel(
        sectionTitleRowModel: SectionTitleRowModel(
          title: _appLocalization
              .translate('homeScreenTxtRecommendedSectionTitle'),
          seeMore: false,
          press: () {},
        ),
        child: MultiProvider(
          providers: [
            StreamProvider<List<UserRecommendedPostCard>>.value(
              initialData: const [],
              value: _firestoreDatabase.userRecommendedPostCardsStream(),
            ),
            StreamProvider<List<PostCard>>.value(
              initialData: const [],
              value: _firestoreDatabase.recommendedPostCardsStream(),
            ),
          ],
          child: const Center(child: HomeScreenRecommendedPostCards()),
        ),
      ),
    );
  }
}
