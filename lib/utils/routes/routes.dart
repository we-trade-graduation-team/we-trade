import 'package:flutter/material.dart';

import '../../models/ui/chat/temp_class.dart';
import '../../ui/account_features/follow_screen/follow_screen.dart';
import '../../ui/account_features/my_rate_screen/my_rate_screen.dart';
import '../../ui/account_features/post_management/hide_post_screen.dart';
import '../../ui/account_features/post_management/post_management_screen.dart';
// import '../../ui/account_features/trading_history/rate_for_trading.dart';
import '../../ui/account_features/trading_history/trading_history_screen.dart';
import '../../ui/account_features/user_info/change_password_screen.dart';
import '../../ui/account_features/user_info/user_info_screen.dart';
import '../../ui/authentication_features/complete_profile_screen/complete_profile_screen.dart';
import '../../ui/authentication_features/forgot_password_screen/forgot_password_screen.dart';
import '../../ui/authentication_features/otp_screen/otp_screen.dart';
import '../../ui/authentication_features/shared_widgets/authentication.dart';
import '../../ui/home_features/category_kind_screen/category_kind_screen.dart';
import '../../ui/home_features/notification_screen/detailed_notification_screen.dart';
import '../../ui/home_features/notification_screen/notification_screen.dart';
import '../../ui/home_features/post_details_screen/post_details_screen.dart';
import '../../ui/home_features/searching_screen/search_screen.dart';
import '../../ui/message_features/chat_screen/chat_room/chat_room.dart';
import '../../ui/message_features/match_post/match_post_screen.dart';
import '../../ui/message_features/offer_screens/make_offer_screen.dart';
import '../../ui/message_features/offer_screens/offer_detail_screen.dart';
import '../../ui/posting_features/post_items/post_item_step_four.dart';
import '../../ui/posting_features/post_items/post_item_step_three.dart';
import '../../ui/posting_features/post_items/post_item_step_two.dart';
import '../../ui/shared_features/other_user_profile/other_user_profile_screen.dart';
import '../../ui/shared_features/report/report_screen.dart';
import '../../ui/wish_list_features/wish_list/wish_list_screen.dart';

class Routes {
  Routes._();

  // Account features
  static const followScreenRouteName = '/follow';
  static const myRateScreenRouteName = '/my-rate';
  static const hidePostScreenRouteName = '/hide-post';
  static const postManagementScreenRouteName = '/post-management';
  static const rateForTradingScreenRouteName = '/rate-for-trading';
  static const tradingHistoryScreenRouteName = '/trading-history';
  static const changePasswordScreenRouteName = '/change-password';
  static const userInfoScreenRouteName = '/user-info';
  static const wishListScreenRouteName = '/wish-list';
  static const authenticationRouteName = '/authentication';

  // Authentication features
  static const completeProfileScreenRouteName = '/complete-profile';
  static const forgotPasswordScreenRouteName = '/forgot-password';
  static const otpScreenRouteName = '/otp';

  // Home features
  static const categoryKindScreenRouteName = '/category-kind';
  static const postDetailScreenRouteName = '/post-detail';
  static const detailNotificationScreenRouteName = '/detail-notification';
  static const notificationScreenRouteName = '/notification';
  static const searchScreenRouteName = '/search';

  // Shared features
  static const otherProfileScreenRouteName = '/other-profile';
  static const reportScreenRouteName = '/report';

  // Message features
  static const addChatScreenRouteName = '/add-chat';
  static const groupChatScreenRouteName = '/group-chat';
  static const allMemberScreenRouteName = '/all-member';
  static const personChatScreenRouteName = '/person-chat';
  static const matchPostsScreenRouteName = '/match-posts';
  static const makeOfferScreenRouteName = '/make-offer';
  static const offerDetailScreenRouteName = '/offer-detail';
  static const chatRoomScreenRouteName = '/chat-room';

  // Posting features

  static const postItemStepTwoScreenRouteName = '/post-item-step-two';
  static const postItemStepThreeScreenRouteName = '/post-item-step-three';
  static const postItemStepFourScreenRouteName = '/post-item-step-four';

  // Update features

  static const updateItemStepOneScreenRouteName = '/post-item-step-one';

  static final Map<String, WidgetBuilder> accountFeaturesRoutes = {
    followScreenRouteName: (_) => const FollowScreen(),
    myRateScreenRouteName: (_) => MyRateScreen(),
    hidePostScreenRouteName: (_) => const HidePostScreen(),
    postManagementScreenRouteName: (_) => const PostManagementScreen(),
    // rateForTradingScreenRouteName: (_) => const RateForTrading(),
    tradingHistoryScreenRouteName: (_) => const TradingHistoryScreen(),
    changePasswordScreenRouteName: (_) => const ChangePasswordScreen(),
    userInfoScreenRouteName: (_) => const UserInfoScreen(),
    wishListScreenRouteName: (_) => const WishListScreen(),
    authenticationRouteName: (_) => const Authentication(),
  };

  static final Map<String, WidgetBuilder> authenticationFeaturesRoutes = {
    completeProfileScreenRouteName: (_) => const CompleteProfileScreen(),
    forgotPasswordScreenRouteName: (_) => const ForgotPasswordScreen(),
    otpScreenRouteName: (_) => const OtpScreen(phoneNumber: '+8801376221100'),
    authenticationRouteName: (_) => const Authentication(),
  };

  static final Map<String, WidgetBuilder> homeFeaturesRoutes = {
    categoryKindScreenRouteName: (_) => const CategoryKindScreen(mainCategory: '',mainCategoryName: '',),
    postDetailScreenRouteName: (_) => const PostDetailsScreen(),
    detailNotificationScreenRouteName: (_) =>
        DetailedNotificationScreen(note: chosenNote,),
    notificationScreenRouteName: (_) => const NotificationScreen(),
    searchScreenRouteName: (_) => const SearchScreen(),
    ...sharedFeaturesRoutes,
  };

  static final Map<String, WidgetBuilder> sharedFeaturesRoutes = {
    otherProfileScreenRouteName: (_) => const OtherUserProfileScreen(
          userId: '',
        ),
    reportScreenRouteName: (_) => const ReportScreen(objectId: '',),
    makeOfferScreenRouteName: (_) => const MakeOfferScreen(
          otherUserPostId: '',
        ),
  };

  static final Map<String, WidgetBuilder> messageFeaturesRoutes = {
    chatRoomScreenRouteName: (_) => ChatRoomScreen(chat: Chat.nullChat()),
    matchPostsScreenRouteName: (_) => const MatchPostsScreen(),
    offerDetailScreenRouteName: (_) => OfferDetailScreen(
          trading: Trading.nullTrading(),
        ),
    ...sharedFeaturesRoutes,
  };

  static final Map<String, WidgetBuilder> postingFeaturesRoutes = {
    postItemStepTwoScreenRouteName: (_) => const PostItemTwo(),
    postItemStepThreeScreenRouteName: (_) => const PostItemThree(),
    postItemStepFourScreenRouteName: (_) => const PostItemFour(),
  };
}
