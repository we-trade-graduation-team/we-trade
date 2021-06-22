import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';
import 'post_details_similar_post_cards.dart';

class PostDetailsSimilarPostCardsSection extends StatelessWidget {
  const PostDetailsSimilarPostCardsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _args = context.watch<PostDetailsArguments>();

    final _postId = _args.postId;

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _size = MediaQuery.of(context).size;

    final _appLocalization = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostDetailsSectionContainer(
          child: Text(_appLocalization
              .translate('postDetailsTxtSimilarPostCardsSectionTitle')),
        ),
        PostDetailsSeparator(height: _size.height * 0.004),
        Container(
          width: _size.width,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: _size.width * 0.05,
            top: _size.height * 0.02,
            bottom: _size.height * 0.02,
          ),
          child: FutureProvider<List<PostCard>?>.value(
            value: _firestoreDatabase.getPostDetailsScreenSimilarPostCards(
              postId: _postId,
            ),
            initialData: null,
            catchError: (_, __) => const [],
            child: const PostDetailsSimilarPostCards(),
          ),
        ),
      ],
    );
  }
}
