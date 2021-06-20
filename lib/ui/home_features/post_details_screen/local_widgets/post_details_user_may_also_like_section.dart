import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../widgets/item_post_card.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';

class PostDetailsUserMayAlsoLikeSection extends StatelessWidget {
  const PostDetailsUserMayAlsoLikeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postCardsCurrentUserMayAlsoLike =
        context.select<PostDetailsArguments, List<PostCard>>(
            (arguments) => arguments.postCardsCurrentUserMayAlsoLike);

    final _size = MediaQuery.of(context).size;

    return Column(
      children: [
        const PostDetailsSectionContainer(
          child: Text('You may also like'),
        ),
        PostDetailsSeparator(height: _size.height * 0.004),
        Container(
          width: _size.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            // horizontal: size.width * kDetailHorizontalPaddingPercent,
            vertical: _size.height * AppDimens.kDetailVerticalPaddingPercent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  children: _postCardsCurrentUserMayAlsoLike
                      .map(
                        (postCard) => ItemPostCard(postCard: postCard),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: _size.height * 0.004),
              TextButton.icon(
                icon: const Icon(LineIcons.angleDown),
                // style: TextButton.styleFrom(
                //   primary: Theme.of(context).primaryColor,
                // ),
                onPressed: () {},
                label: const Text('Load more'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
