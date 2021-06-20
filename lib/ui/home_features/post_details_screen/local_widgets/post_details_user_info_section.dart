import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_details_model/post_details_owner/post_details_owner.dart';
import '../../shared_widgets/rounded_outline_button.dart';
import 'post_details_follow_toggle_button.dart';
import 'post_details_section_container.dart';
import 'post_details_small_rating_thumbnail.dart';

class PostDetailsUserInfoSection extends StatelessWidget {
  const PostDetailsUserInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postDetailsOwnerInfo =
        context.select<PostDetailsArguments, PostDetailsOwner>(
            (arguments) => arguments.postDetails.ownerInfo);

    final _size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          PostDetailsSectionContainer(
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: _size.height * 0.068,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            _postDetailsOwnerInfo.avatarURL,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _postDetailsOwnerInfo.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Active 9 hours ag',
                          style: TextStyle(
                            fontSize: 13,
                            color: ((Theme.of(context).textTheme.bodyText2)!
                                    .color)!
                                .withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: _size.height * 0.075,
            child: Center(
              child: PostDetailsSmallRatingThumbnail(
                legitimacy: _postDetailsOwnerInfo.legitimacy,
              ),
              // child: CustomAnimationLimiterForListView<UserRating>(
              //   scrollDirection: Axis.horizontal,
              //   scrollPhysics: const NeverScrollableScrollPhysics(),
              //   separatorWidth: 35,
              //   duration: const Duration(
              //       milliseconds:
              //           AppDimens.kFlutterStaggeredAnimationsDuration ~/ 2),
              //   endIndent: _size.height * 0.04,
              //   list: product.owner.ratings!,
              //   builder: (_, userRating) {
              //     return SmallRatingThumbnail(
              //       userRating: userRating,
              //     );
              //   },
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const PostDetailsFollowToggleButton(),
                const SizedBox(width: 10),
                RoundedOutlineButton(
                  text: 'Profile',
                  borderColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                  press: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
