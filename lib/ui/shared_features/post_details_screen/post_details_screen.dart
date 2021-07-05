import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../app_localizations.dart';
import '../../../constants/app_colors.dart';
import '../../../models/arguments/shared/post_details_arguments.dart';
import '../../../models/cloud_firestore/post_model/post/post.dart';
import '../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../providers/loading_overlay_provider.dart';
import '../../../services/firestore/firestore_database.dart';
import '../../../utils/routes/routes.dart';
import '../../message_features/helper/helper_navigate_chat_room.dart';
import '../../message_features/offer_screens/make_offer_screen.dart';
import 'local_widgets/post_details_body.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as PostDetailsArguments;

    final _postId = _args.postId;

    final _ownerId = _args.ownerId;

    final _currentUser = context.watch<User>();

    final _currentUserId = _currentUser.uid!;

    final _isAPostOfCurrentUser = _ownerId == _currentUserId;

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _appLocalization = AppLocalizations.of(context);

    final _size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.kScreenBackgroundColor,
      body: ChangeNotifierProvider<LoadingOverlayProvider>(
        create: (_) => LoadingOverlayProvider(),
        child: Consumer<LoadingOverlayProvider>(
          builder: (_, loadingOverlay, __) {
            return LoadingOverlay(
              isLoading: loadingOverlay.isLoading,
              color: Colors.white,
              opacity: 1,
              child: MultiProvider(
                providers: [
                  FutureProvider<Post>.value(
                    value: _firestoreDatabase.getPost(
                      postId: _postId,
                    ),
                    initialData: Post.initialData(),
                    catchError: (_, __) => Post.initialData(),
                  ),
                  Provider<PostDetailsArguments>.value(
                    value: _args,
                  ),
                  Provider<bool>.value(
                    value: _isAPostOfCurrentUser,
                  ),
                ],
                child: const PostDetailsBody(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: !_isAPostOfCurrentUser
          ? Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onMakeOfferButtonPressed(
                      postId: _postId,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: _buttonPadding,
                    ),
                    child: Text(
                      _appLocalization
                          .translate('postDetailsTxtMakeOfferButton'),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onChatButtonPressed(
                      ownerId: _ownerId,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: _buttonPadding,
                      onPrimary: Theme.of(context).primaryColor,
                      primary: Colors.white,
                      // elevation: 20,
                    ),
                    child: Text(
                      _appLocalization.translate('postDetailsTxtChatButton'),
                    ),
                  ),
                )
              ],
            )
          : Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: _size.height * 0.02),
              child: Text(
                _appLocalization.translate('postDetailsTxtViewerIsOwner'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
    );
  }

  EdgeInsetsGeometry get _buttonPadding {
    final _size = MediaQuery.of(context).size;

    return EdgeInsets.symmetric(
      horizontal: _size.width * 0.05,
      vertical: _size.height * 0.02,
    );
  }

  Future<void> _onMakeOfferButtonPressed({
    required String postId,
  }) async {
    return pushNewScreenWithRouteSettings<void>(
      context,
      settings: const RouteSettings(
        name: Routes.makeOfferScreenRouteName,
      ),
      screen: MakeOfferScreen(
        otherUserPostId: postId,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void _onChatButtonPressed({
    required String ownerId,
  }) {
    final _currentUser = context.read<User>();

    HelperNavigateChatRoom.checkAndSendChatRoomOneUserByIds(
      context: context,
      thisUser: _currentUser,
      userId: ownerId,
    );
  }
}
