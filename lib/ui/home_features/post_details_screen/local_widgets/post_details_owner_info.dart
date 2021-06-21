import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../constants/app_assets.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../../providers/post_details_follow_provider.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../../../utils/routes/routes.dart';
import '../../../shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../shared_widgets/rounded_outline_button.dart';
import 'post_details_follow_toggle_button.dart';
import 'post_details_section_container.dart';
import 'post_details_small_rating_thumbnail.dart';

class PostDetailsOwnerInfo extends StatefulWidget {
  const PostDetailsOwnerInfo({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsOwnerInfoState createState() => _PostDetailsOwnerInfoState();
}

class _PostDetailsOwnerInfoState extends State<PostDetailsOwnerInfo> {
  @override
  Widget build(BuildContext context) {
    final _postDetailsOwnerId = context.watch<String>();

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _size = MediaQuery.of(context).size;

    // Add a new locale messages
    timeago.setLocaleMessages('vi', timeago.ViShortMessages());

    return FutureProvider<User?>.value(
      value: _firestoreDatabase.getUser(
        userId: _postDetailsOwnerId,
      ),
      initialData: null,
      catchError: (_, __) => User.initialData(),
      child: Consumer<User?>(
        builder: (_, user, __) {
          return user == null
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : Column(
                  children: [
                    PostDetailsSectionContainer(
                      child: IntrinsicHeight(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: _size.height * 0.068,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                      imageUrl: user.avatarUrl ??
                                          AppAssets.userImageStr,
                                      imageBuilder: (_, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (_, __) => Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      errorWidget: (_, __, dynamic ___) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name ?? 'Unknown',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Active ${timeago.format(DateTime.fromMillisecondsSinceEpoch(user.lastSeen ?? DateTime.now().microsecondsSinceEpoch))}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: ((Theme.of(context)
                                                  .textTheme
                                                  .bodyText2)!
                                              .color)!
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 25),
                            PostDetailsSmallRatingThumbnail(
                              legitimacy: user.legit,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FutureProvider<bool?>.value(
                            value:
                                _firestoreDatabase.isCurrentUserAFollowerOfUser(
                              userId: _postDetailsOwnerId,
                            ),
                            initialData: null,
                            catchError: (_, __) => false,
                            child: Consumer<bool?>(
                              builder: (_, isFollowed, __) {
                                return isFollowed == null
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : ChangeNotifierProvider<
                                        PostDetailsFollowProvider>(
                                        create: (_) =>
                                            PostDetailsFollowProvider(
                                          isFollowed: isFollowed,
                                        ),
                                        child:
                                            const PostDetailsFollowToggleButton(),
                                      );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          RoundedOutlineButton(
                            text: 'Profile',
                            borderColor: Theme.of(context).primaryColor,
                            backgroundColor: Theme.of(context).primaryColor,
                            press: _onProfileButtonPress,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Future<void> _onProfileButtonPress() async {
    final _args = context.read<PostDetailsArguments>();

    final _postOwnerId = _args.ownerId;

    final _currentUser = context.read<User>();

    final _currentUserId = _currentUser.uid!;

    if (_postOwnerId == _currentUserId) {
      return;
    }

    return _navigateToOtherUserProfileScreen(
      postOwnerId: _postOwnerId,
    );
  }

  Future<void> _navigateToOtherUserProfileScreen({
    required String postOwnerId,
  }) async {
    return pushNewScreenWithRouteSettings<void>(
      context,
      screen: OtherUserProfileScreen(
        userId: postOwnerId,
      ),
      settings: const RouteSettings(
        name: Routes.otherProfileScreenRouteName,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
