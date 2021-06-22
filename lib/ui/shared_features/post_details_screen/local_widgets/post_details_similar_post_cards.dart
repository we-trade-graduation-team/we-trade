import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../widgets/shared_circular_progress_indicator.dart';
import '../../../home_features/shared_widgets/horizontal_scroll_post_card_list_view.dart';
import 'post_details_no_items_section.dart';

class PostDetailsSimilarPostCards extends StatelessWidget {
  const PostDetailsSimilarPostCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _similarPostCards = context.watch<List<PostCard>?>();

    if (_similarPostCards == null) {
      return const SharedCircularProgressIndicator();
    }

    if (_similarPostCards.isEmpty) {
      final _appLocalization = AppLocalizations.of(context);

      return PostDetailsNoItemsSection(
          text: _appLocalization.translate('postDetailsTxtNoPostCards'));
    }

    return HorizontalScrollPostCardListView(
      postCards: _similarPostCards,
    );
  }
}
