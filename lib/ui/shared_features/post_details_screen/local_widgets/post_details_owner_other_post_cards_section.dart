import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../models/cloud_firestore/post_model/post/post.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'post_details_owner_other_post_cards.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';

class PostDetailsOwnerOtherPostCardsSection extends StatelessWidget {
  const PostDetailsOwnerOtherPostCardsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postOwnerId = context.select<Post, String>((post) => post.owner);

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _size = MediaQuery.of(context).size;

    final _appLocalization = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostDetailsSectionContainer(
          child: Text(_appLocalization
              .translate('postDetailsTxtOwnerOtherPostCardsSectionTitle')),
        ),
        PostDetailsSeparator(height: _size.height * 0.004),
        Container(
          color: Colors.white,
          width: _size.width,
          padding: EdgeInsets.only(
            left: _size.width * 0.05,
            top: _size.height * 0.02,
            bottom: _size.height * 0.02,
          ),
          child: FutureProvider<List<PostCard>?>.value(
            value: _firestoreDatabase.getPostCardsByUserId(
              userId: _postOwnerId,
            ),
            initialData: null,
            catchError: (_, __) => const [],
            child: const PostDetailsOwnerOtherPostCards(),
          ),
        ),
      ],
    );
  }
}
