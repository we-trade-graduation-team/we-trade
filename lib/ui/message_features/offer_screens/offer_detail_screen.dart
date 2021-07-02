import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../models/ui/chat/chat.dart';
import '../../../services/firestore/firestore_database.dart';
import '../../../services/trading_feature/trading_service_firestore.dart';
import '../../../utils/routes/routes.dart';
import '../../../widgets/custom_material_button.dart';
import '../../../widgets/item_post_card.dart';
import '../../shared_features/other_user_profile/other_user_profile_screen.dart';
import '../const_string/const_str.dart';

class OfferDetailScreen extends StatefulWidget {
  const OfferDetailScreen({
    Key? key,
    required this.trading,
  }) : super(key: key);

  final Trading trading;

  @override
  _OfferDetailScreenState createState() => _OfferDetailScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Trading>('trading', trading));
  }
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  late bool loading = true;
  // ignore: diagnostic_describe_all_properties
  // ignore: avoid_init_to_null
  late PostCard? ownerPost = null;
  late List<PostCard> offerPosts = [];
  late int status = 0;

  void navigateToOtherUserProfile() {
    final thisUserId = Provider.of<User?>(context, listen: false)!.uid;
    if (widget.trading.offerId != thisUserId) {
      pushNewScreenWithRouteSettings<void>(
        context,
        settings: const RouteSettings(
          name: Routes.otherProfileScreenRouteName,
        ),
        screen: OtherUserProfileScreen(
          userId: widget.trading.offerId,
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    } else {
      pushNewScreenWithRouteSettings<void>(
        context,
        settings: const RouteSettings(
          name: Routes.otherProfileScreenRouteName,
        ),
        screen: OtherUserProfileScreen(
          userId: widget.trading.ownerId,
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
  }

  Future<void> updateStatusTrading(int newStatus, String tradingId) async {
    await TradingServiceFireStore()
        .updateStatusOfTradingById(tradingId: tradingId, status: newStatus)
        .then((value) {
      var alertStr = '';
      setState(() {
        status = value;
      });
      if (value == newStatus) {
        alertStr = 'Cập nhật thành công';
        if (value == 1) {
          TradingServiceFireStore()
              .updatePostsWhenTradingSuccess(widget.trading);
        }
      } else {
        alertStr = 'giao dịch đã được đối tác chỉnh sửa trạng thái';
      }
      _showMyDialog(alertStr);
    });
  }

  Future<void> _showMyDialog(String alertStr) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Text(alertStr),
          actions: <Widget>[
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

  Widget buildListPostCardWidget(List<PostCard> posts) {
    return loading
        ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Lottie.network(messageLoadingStr2, width: 100, height: 100),
            const Text('loading ...'),
          ])
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: posts != null
                ? Row(
                    children: [
                      ...List.generate(
                        posts.length,
                        (index) {
                          return Row(
                            children: [
                              ItemPostCard(
                                  isNavigateToDetailScreen: false,
                                  postCard: posts[index]),
                              const SizedBox(width: 20),
                            ],
                          );
                        },
                      )
                    ],
                  )
                : Row(
                    children: const [
                      SizedBox(width: 20),
                      Text(
                        'no data',
                        style: TextStyle(color: AppColors.kReviewTextLabel),
                      ),
                    ],
                  ));
  }

  Widget buildMoneyOffer() {
    if (widget.trading.isHaveMoney) {
      final thisUserId = Provider.of<User?>(context, listen: false)!.uid;
      var str = '';
      if (widget.trading.offerId == thisUserId) {
        str = 'Số tiền MINE offer';
      } else {
        str = 'Số tiền YOUR offer';
      }
      return Column(children: [
        const SizedBox(height: 20),
        OfferDetailContainerContain(
          childWidget: Text(
            str,
            style: const TextStyle(
              fontSize: 16,
              //fontWeight: FontWeight.bold,
            ),
          ),
          bottomMargin: 0.5,
        ),
        OfferDetailContainerContain(
          childWidget: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: TextFormField(
              enabled: false,
              initialValue: widget.trading.money.toString(),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                hintStyle: TextStyle(height: 2),
                labelText: '',
              ),
            ),
          ),
          bottomMargin: 3,
        ),
      ]);
    } else {
      return Container();
    }
  }

  String buildTextTittle(String userId) {
    final thisUserId = Provider.of<User?>(context, listen: false)!.uid;

    if (userId == thisUserId) {
      return 'MINE - sản phẩm';
    } else {
      return 'YOUR - sản phẩm';
    }
  }

  Widget buildButtonWidget() {
    if (status == 2) {
      final thisUserId = Provider.of<User?>(context, listen: false)!.uid;
      if (widget.trading.offerId == thisUserId) {
        //nếu là người người chỉ có 1 nút bấm là thu hồi lại đề nghị
        return Container(
          color: AppColors.kScreenBackgroundColor,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomMaterialButton(
                      press: () {
                        updateStatusTrading(3, widget.trading.id);
                      },
                      isFilled: false,
                      text: 'THU HỒI',
                      width: MediaQuery.of(context).size.width / 4,
                      fontSize: 15,
                      height: 40),
                ),
              ),
            ],
          ),
        );
      } else {
        //nếu là người được gửi đến sẽ có 2 nút bấm
        // từ chối đề nghị
        // chấp nhận đề nghị
        return Container(
          color: AppColors.kScreenBackgroundColor,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomMaterialButton(
                      press: () {
                        updateStatusTrading(3, widget.trading.id);
                      },
                      isFilled: false,
                      text: 'TỪ CHỐI',
                      width: MediaQuery.of(context).size.width / 4,
                      fontSize: 15,
                      height: 40),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomMaterialButton(
                      press: () {
                        updateStatusTrading(1, widget.trading.id);
                      },
                      text: 'CHẤP NHẬN',
                      width: MediaQuery.of(context).size.width / 4,
                      fontSize: 15,
                      height: 40),
                ),
              ),
            ],
          ),
        );
      }
    } else if (status == 1) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: AppColors.kScreenBackgroundColor,
          child: const Text(
            'Giao dịch đã thành công',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ));
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: AppColors.kScreenBackgroundColor,
          child: Text('Giao dịch đã thất bại',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400])));
    }
  }

  Widget buildNavigateToUserProfile() {
    return GestureDetector(
      onTap: navigateToOtherUserProfile,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Trang cá nhân đối tác',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )),
              SizedBox(width: 20),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    TradingServiceFireStore()
        .getStatusOfTrading(widget.trading.id)
        .then((value) => setState(() {
              status = value;
            }));
    final _firestoreDatabase = context.read<FirestoreDatabase>();
    _firestoreDatabase
        .getPostCard(postId: widget.trading.ownerPost)
        .then((resultOwnerPost) {
      if (widget.trading.offerPosts.isNotEmpty) {
        _firestoreDatabase
            .getPostCardsByPostIdList(
          postIdList: widget.trading.offerPosts,
          shouldSortViewDescending: true,
        )
            .then((resultOfferPosts) {
          setState(() {
            ownerPost = resultOwnerPost;
            offerPosts = resultOfferPosts;
            loading = false;
          });
        });
      } else {
        setState(() {
          ownerPost = resultOwnerPost;
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const bottomMargin = 0.5;
    return Scaffold(
      appBar: AppBar(
        title: const Text('OFFER DETAIL'),
      ),
      body: Container(
        color: AppColors.kScreenBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // OfferDetailContainerContain(
                    //   childWidget: buildNavigateToUserProfile(),
                    //   bottomMargin: bottomMargin,
                    // ),
                    const SizedBox(height: 20),
                    buildNavigateToUserProfile(),
                    const SizedBox(height: 20),
                    /**
                     * offer detail
                     */
                    OfferDetailContainerContain(
                      childWidget: Text(
                        buildTextTittle(widget.trading.offerId),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      bottomMargin: bottomMargin,
                    ),
                    OfferDetailContainerContain(
                      childWidget: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: buildListPostCardWidget(offerPosts)),
                      bottomMargin: 5,
                    ),
                    buildMoneyOffer(),
                    /**
                     * owner detail
                     */
                    const SizedBox(height: 20),
                    OfferDetailContainerContain(
                      childWidget: Text(
                        buildTextTittle(widget.trading.ownerId),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      bottomMargin: bottomMargin,
                    ),
                    OfferDetailContainerContain(
                      childWidget: buildListPostCardWidget(
                          ownerPost == null ? [] : [ownerPost!]),
                      bottomMargin: bottomMargin,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: buildButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('loading', loading));
    properties.add(IntProperty('status', status));
    properties.add(IterableProperty<PostCard>('offerPosts', offerPosts));
    properties.add(DiagnosticsProperty<PostCard?>('ownerPost', ownerPost));
  }
}

class OfferDetailContainerContain extends StatelessWidget {
  const OfferDetailContainerContain({
    Key? key,
    required this.childWidget,
    required this.bottomMargin,
  }) : super(key: key);

  final Widget childWidget;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(0, 5, 0, bottomMargin),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: childWidget,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('bottomMargin', bottomMargin));
  }
}
