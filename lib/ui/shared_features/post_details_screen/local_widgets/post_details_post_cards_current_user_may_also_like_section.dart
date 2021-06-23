import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../constants/app_number_constants.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'post_details_post_cards_current_user_may_also_like.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';

class PostDetailsPostCardsCurrentUserMayAlsoLikeSection
    extends StatelessWidget {
  const PostDetailsPostCardsCurrentUserMayAlsoLikeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _size = MediaQuery.of(context).size;

    final _appLocalization = AppLocalizations.of(context);

    return Column(
      children: [
        PostDetailsSectionContainer(
          child: Text(_appLocalization.translate(
              'postDetailsTxtCurrentUserMayAlsoLikePostCardsSectionTitle')),
        ),
        PostDetailsSeparator(height: _size.height * 0.004),
        Container(
          width: _size.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            // horizontal: size.width * kDetailHorizontalPaddingPercent,
            vertical: _size.height * AppNumberConstants.kDetailVerticalPaddingPercent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: FutureProvider<List<PostCard>?>.value(
                  value: _firestoreDatabase
                      .getPostDetailsPostCardsCurrentUserMayAlsoLike(),
                  initialData: null,
                  catchError: (_, __) => const [],
                  child: const PostDetailsPostCardsCurrentUserMayAlsoLike(),
                ),
              ),
              SizedBox(height: _size.height * 0.004),
              // TextButton.icon(
              //   icon: const Icon(LineIcons.angleDown),
              //   onPressed: () {},
              //   label: const Text('Load more'),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
