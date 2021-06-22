import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../constants/app_dimens.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../../utils/routes/routes.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import '../../../message_features/offer_screens/make_offer_screen.dart';
import 'post_details_description_section.dart';
import 'post_details_faq_section.dart';
import 'post_details_owner_info_section.dart';
import 'post_details_owner_other_post_cards_section.dart';
import 'post_details_post_cards_current_user_may_also_like_section.dart';
import 'post_details_similar_post_cards_section.dart';
import 'post_details_title_section.dart';
import 'post_details_trade_for_info_section.dart';

class PostDetailsSectionsBox extends StatefulWidget {
  const PostDetailsSectionsBox({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsSectionsBoxState createState() => _PostDetailsSectionsBoxState();
}

class _PostDetailsSectionsBoxState extends State<PostDetailsSectionsBox> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final _appLocalization = AppLocalizations.of(context);

    final _detailChildren = [
      const PostDetailsTitleSection(),
      const PostDetailsTradeForInfoSection(),
      ElevatedButton(
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
          horizontal: _size.width * 0.05,
          vertical: _size.height * 0.02,
        )),
        child: Text(
          _appLocalization.translate('postDetailsTxtMakeOfferButton'),
        ),
      ),
      const PostDetailsDescriptionSection(),
      const PostDetailsOwnerInfoSection(),
      const PostDetailsOwnerOtherPostCardsSection(),
      const PostDetailsFaqSection(),
      const PostDetailsSimilarPostCardsSection(),
      const PostDetailsPostCardsCurrentUserMayAlsoLikeSection(),
    ];

    return SliverToBoxAdapter(
      child: CustomAnimationLimiterForListView<Widget>(
        scrollDirection: Axis.vertical,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        separatorHeight: _size.height * 0.02,
        // separatorColor: Colors.transparent,
        duration: const Duration(
            milliseconds: AppDimens.kFlutterStaggeredAnimationsDuration ~/ 2),
        list: _detailChildren,
        builder: (_, widget) => widget,
      ),
    );
  }

  Future<void> _showMyDialog(String alertStr) async {
    final _appLocalization = AppLocalizations.of(context);

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_appLocalization.translate('postDetailsTxtNotification')),
          content: Text(alertStr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onPressed() async {
    final _args = context.read<PostDetailsArguments>();

    final _postId = _args.postId;

    final _ownerId = _args.ownerId;

    final _currentUser = context.read<User>();

    final _currentUserId = _currentUser.uid!;

    if (_ownerId != _currentUserId) {
      return pushNewScreenWithRouteSettings<void>(
        context,
        settings: const RouteSettings(
          name: Routes.makeOfferScreenRouteName,
        ),
        screen: MakeOfferScreen(
          otherUserPostId: _postId,
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
    final _appLocalization = AppLocalizations.of(context);

    return _showMyDialog(
        _appLocalization.translate('postDetailsTxtSameOwnerNotification'));
  }
}
