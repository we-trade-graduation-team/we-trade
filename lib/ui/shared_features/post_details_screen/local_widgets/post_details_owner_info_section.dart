import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../app_localizations.dart';
import '../../../../constants/app_assets.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../../providers/post_details_follow_provider.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../../../utils/routes/routes.dart';
import '../../../../widgets/shared_circular_progress_indicator.dart';
import '../../../home_features/shared_widgets/rounded_outline_button.dart';
import '../../../shared_features/other_user_profile/other_user_profile_screen.dart';
import 'post_details_follow_toggle_button.dart';
import 'post_details_section_container.dart';
import 'post_details_small_rating_thumbnail.dart';

class PostDetailsOwnerInfoSection extends StatefulWidget {
  const PostDetailsOwnerInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsOwnerInfoSectionState createState() =>
      _PostDetailsOwnerInfoSectionState();
}

class _PostDetailsOwnerInfoSectionState
    extends State<PostDetailsOwnerInfoSection> {
  @override
  Widget build(BuildContext context) {
    final _args = context.watch<PostDetailsArguments>();

    final _ownerId = _args.ownerId;

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _size = MediaQuery.of(context).size;

    final _appLocalization = AppLocalizations.of(context);

    // Add a new locale messages
    timeago.setLocaleMessages('vi', timeago.ViShortMessages());

    return Container(
      color: Colors.white,
      child: FutureProvider<User?>.value(
        value: _firestoreDatabase.getUser(
          userId: _ownerId,
        ),
        initialData: null,
        catchError: (_, __) => User.initialData(),
        child: Consumer<User?>(
          builder: (_, user, __) {
            if (user == null) {
              return const SharedCircularProgressIndicator();
            }

            return Column(
              children: [
                PostDetailsSectionContainer(
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: _onProfileButtonPress,
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
                                    placeholder: (_, __) =>
                                        const SharedCircularProgressIndicator(),
                                    errorWidget: (_, __, dynamic ___) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  color:
                                      ((Theme.of(context).textTheme.bodyText2)!
                                              .color)!
                                          .withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(width: 20),
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
                        value: _firestoreDatabase.isCurrentUserAFollowerOfUser(
                          userId: _ownerId,
                        ),
                        initialData: null,
                        catchError: (_, __) => false,
                        child: Consumer<bool?>(
                          builder: (_, isFollowed, __) {
                            if (isFollowed == null) {
                              return const SharedCircularProgressIndicator();
                            }
                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider<
                                    PostDetailsFollowProvider>(
                                  create: (_) => PostDetailsFollowProvider(
                                    isFollowed: isFollowed,
                                  ),
                                ),
                                Provider<MessageServiceFireStore>(
                                  create: (_) => MessageServiceFireStore(),
                                )
                              ],
                              child: const PostDetailsFollowToggleButton(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      RoundedOutlineButton(
                        text: _appLocalization
                            .translate('postDetailsTxtProfileButton'),
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
      ),
    );
  }

  Future<void> _onProfileButtonPress() async {
    final _args = context.read<PostDetailsArguments>();

    final _ownerId = _args.ownerId;

    final _currentUser = context.read<User>();

    final _currentUserId = _currentUser.uid!;

    if (_ownerId == _currentUserId) {
      return;
    }

    return _navigateToOtherUserProfileScreen(
      postOwnerId: _ownerId,
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
