import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/post_card/post_card.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';
import '../../../../models/ui/home_features/home_screen/section_title_row_model.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../../../widgets/item_post_card.dart';
import 'home_screen_section_column.dart';

class HomeScreenRecommendedSection extends StatelessWidget {
  const HomeScreenRecommendedSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final _appLocalization = AppLocalizations.of(context);

    return HomeScreenSectionColumn(
      sectionColumnModel: SectionColumnModel(
        sectionTitleRowModel: SectionTitleRowModel(
          title: _appLocalization
              .translate('homeScreenTxtRecommendedSectionTitle'),
          seeMore: false,
          press: () {},
        ),
        child: StreamProvider<List<PostCard>>.value(
          initialData: const [],
          value: _firestoreDatabase.userRecommendedPostCardsStream(),
          child: Center(
            child: Consumer<List<PostCard>>(
              builder: (_, postCards, __) {
                return Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  children: postCards
                      .map(
                        (postCard) => ItemPostCard(postCard: postCard),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
