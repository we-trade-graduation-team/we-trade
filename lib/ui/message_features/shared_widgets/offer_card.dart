import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../models/ui/chat/temp_class.dart';
import '../../../services/post_feature/post_service_firestore.dart';
import '../../../services/trading_feature/trading_service_firestore.dart';
import '../../../utils/routes/routes.dart';
import '../const_string/const_str.dart';
import '../offer_screens/offer_detail_screen.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({
    Key? key,
    required this.tradingID,
  }) : super(key: key);

  final String tradingID;

  @override
  _OfferCardState createState() => _OfferCardState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('tradingID', tradingID));
  }
}

class _OfferCardState extends State<OfferCard> {
  // ignore: diagnostic_describe_all_properties
  late Trading trading;
  late bool loading = true;

  void navigateToDetailOffer() {
    pushNewScreenWithRouteSettings<void>(
      context,
      settings: const RouteSettings(
        name: Routes.offerDetailScreenRouteName,
      ),
      screen: OfferDetailScreen(
        trading: trading,
      ),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Widget buildExpansionWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ConfigurableExpansionTile(
        header: buildHeaderExpansionWidget('Offer mới !'),
        headerExpanded: buildHeaderExpansionWidget('Thu nhỏ'),
        children: [buildCardDealContent()],
      ),
    );
  }

  Widget buildHeaderExpansionWidget(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget buildCardDealContent() {
    final thisUserId = Provider.of<User?>(context, listen: false)!.uid;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            color: const Color(0xff525252).withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OfferProductsCard(
            press: navigateToDetailOffer,
            isMe: trading.offerId == thisUserId,
            postId:
                trading.offerPosts.isNotEmpty ? trading.offerPosts[0] : null,
            totalPost: trading.offerPosts.length,
            money: trading.money,
          ),
          const SizedBox(width: 10),
          Icon(
            LineIcons.values['alternateExchange'],
            // color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 10),
          OfferProductsCard(
            press: navigateToDetailOffer,
            isMe: trading.ownerId == thisUserId,
            postId: trading.ownerPost,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    TradingServiceFireStore()
        .getTradingByTradingId(tradingId: widget.tradingID)
        .then((value) {
      if (value.status == 2) {
        setState(() {
          trading = value;
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Container() : buildExpansionWidget();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('loading', loading));
  }
}

class OfferProductsCard extends StatefulWidget {
  const OfferProductsCard({
    Key? key,
    this.postId,
    this.money,
    required this.press,
    required this.isMe,
    this.totalPost = 1,
  }) : super(key: key);

  final String? postId;
  final int? totalPost;
  final int? money;
  final VoidCallback press;
  final bool isMe;

  @override
  _OfferProductsCardState createState() => _OfferProductsCardState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('postId', postId));
    properties.add(IntProperty('totalPost', totalPost));
    properties.add(IntProperty('money', money));
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(DiagnosticsProperty<bool>('isMe', isMe));
  }
}

class _OfferProductsCardState extends State<OfferProductsCard> {
  late String image = loadingImageStr;
  late String title = '...';

  @override
  void initState() {
    super.initState();
    final postService = PostServiceFireStore();
    if (widget.postId != null) {
      postService
          .getFirstPostImage(widget.postId!)
          .then((value) => setState(() {
                image = value;
              }));
      postService
          .getFirstPostTitle(widget.postId!)
          .then((value) => setState(() {
                title = value;
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    String strType;
    if (widget.isMe == true) {
      strType = 'MINE';
    } else {
      strType = 'YOURS';
    }

    return InkWell(
      onTap: widget.press,
      child: Container(
        height: 90,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 5,
              color: const Color(0xff525252).withOpacity(0.25),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.postId != null)
                  Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 50,
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          if (widget.totalPost! > 1)
                            Positioned(
                              top: 3,
                              right: 3,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF4848),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '+${widget.totalPost! - 1}',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
                        child: Text(title,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                if (widget.postId == null)
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFead9ff),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        '\$${widget.money}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Positioned(
              bottom: 3,
              left: 3,
              child: Container(
                width: 40,
                height: 15,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                ),
                child: Center(
                  child: Text(
                    strType,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('image', image));
    properties.add(StringProperty('title', title));
  }
}
