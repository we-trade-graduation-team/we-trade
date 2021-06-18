import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../models/ui/shared_models/product_model.dart';
import '../../../utils/routes/routes.dart';
import '../../message_features/offer_screens/offer_detail_screen.dart';
import '../account_screen/local_widgets/getter.dart';
import '../trading_history/rate_for_trading.dart';
import '../utils.dart';
import 'custom_overlay_icon_button.dart';
import 'geting_data_status.dart';
import 'trading_prod_overlay.dart';

class HistoryProductCard extends StatefulWidget {
  HistoryProductCard({
    Key? key,
    required this.tradingID,
    required this.forProduct,
    this.offerSideProducts,
    this.offerSideMoney,
  }) : super(key: key);

  final statusValue = <String, int>{
    'success': 1,
    'inProgress': 2,
    'failure': 3
  };

  final String tradingID;
  final List<Product>? offerSideProducts;
  final int? offerSideMoney;
  final Product forProduct;

  @override
  _HistoryProductCardState createState() => _HistoryProductCardState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('tradingID', tradingID));
    properties
        .add(IterableProperty<Product>('offerSideProducts', offerSideProducts));
    properties.add(IntProperty('offerSideMoney', offerSideMoney));
    properties.add(DiagnosticsProperty<Product>('forProduct', forProduct));
    properties
        .add(DiagnosticsProperty<Map<String, int>>('statusValue', statusValue));
  }
}

class _HistoryProductCardState extends State<HistoryProductCard> {
  final referenceDatabase = FirebaseFirestore.instance;
  final userID = FirebaseAuth.instance.currentUser!.uid;

  late String otherSideUserID;
  late String ownerPostID;
  late int status;
  late String statusText;
  late Color statusTextColor;
  late String dateTime;
  bool _isLoaded = false;
  Map<String, dynamic>? _user;
  Map<String, dynamic>? _trading;
  int timeOut = 10;

  Future<void> _removeTradingHistory(String tradingID) async {
    try {
      await referenceDatabase
          .collection('users')
          .doc(userID)
          .get()
          .then((documentSnapshot) async {
        _user = documentSnapshot.data();
        final tradingHistoryOfUser = _user!['tradingHistory'] as List;
        tradingHistoryOfUser.remove(tradingID);

        await referenceDatabase
            .collection('users')
            .doc(userID)
            .update({'tradingHistory': tradingHistoryOfUser}).then((value) {
          setState(() {
            _isLoaded = true;
          });
        });
      });
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      referenceDatabase
          .collection('tradings')
          .doc(widget.tradingID)
          .get()
          .then((documentSnapshot) {
        _trading = documentSnapshot.data();
        _trading!['id'] = documentSnapshot.id;

        if (_trading != null) {
          setState(() {
            otherSideUserID = _trading!['owner'].toString() == userID
                ? _trading!['makeOfferUser'].toString()
                : _trading!['owner'].toString();
            ownerPostID = _trading!['ownerPosts'][0].toString();
            final temp = _trading!['createAt'] as Timestamp;
            final d = temp.toDate();
            dateTime = DateFormat.yMMMMd('en_US').add_jm().format(d);
            status = _trading!['status'] as int;
            switch (status) {
              case 1:
                statusText = 'Thành công';
                statusTextColor = Colors.green;
                break;
              case 2:
                statusText = 'Đang giao dịch';
                statusTextColor = Colors.yellow[700]!;
                break;
              case 3:
                statusText = 'Thất bại';
                statusTextColor = Colors.red[400]!;
                break;
              default:
                statusText = 'Unknown';
                statusTextColor = Colors.red[400]!;
                break;
            }

            _isLoaded = true;
          });
        }
      }).timeout(Duration(seconds: timeOut));
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final rateOverlayItem = OverlayItem(
      text: 'Đánh giá',
      iconData: Icons.star,
      handleFunction: () {
        pushNewScreenWithRouteSettings<void>(
          context,
          settings:
              const RouteSettings(name: Routes.rateForTradingScreenRouteName),
          screen: RateForTrading(
              tradingID: widget.tradingID, otherSideUserID: otherSideUserID),
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
    final removeOverlayItem = OverlayItem(
      text: 'Xóa',
      iconData: Icons.delete,
      handleFunction: () async {
        await showMyConfirmationDialog(
            context: context,
            title: 'Thông báo',
            content: 'Bạn có chắc muốn xóa lịch sử giao dịch này không?',
            onConfirmFunction: () {
              _removeTradingHistory(widget.tradingID);
              Navigator.of(context).pop();
            },
            onCancelFunction: () {
              Navigator.of(context).pop();
            });
      },
    );

    return _isLoaded
        ? GestureDetector(
            onTap: () {
              pushNewScreenWithRouteSettings<void>(
                context,
                settings: RouteSettings(
                    name: Routes.offerDetailScreenRouteName,
                    arguments: OfferDetailScreenArguments(
                        forProduct: widget.forProduct,
                        isOfferSide: true,
                        offerSideProducts: widget.offerSideProducts,
                        offerSideMoney: widget.offerSideMoney)),
                screen: const OfferDetailScreen(),
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                //color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.2,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.25,
                        height: width * 0.19,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)),
                        child: FutureBuilder<DocumentSnapshot>(
                            future: referenceDatabase
                                .collection('posts')
                                .doc(ownerPostID)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                final post = snapshot.data!;
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    post['imagesUrl'][0].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black45,
                              ));
                            }),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'TK giao dich: ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                width: width * 0.3,
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: GetUserName(
                                    documentId: otherSideUserID,
                                    isStream: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Text(
                                'Trạng thái: ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                statusText,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: statusTextColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Container(
                            width: width * 0.45,
                            child: Text(
                              dateTime.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomOverlayIconButton(
                        iconData: Icons.more_vert,
                        overlayItems: status == widget.statusValue['success']
                            ? [rateOverlayItem, removeOverlayItem]
                            : [removeOverlayItem],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : const CustomLinearProgressIndicator(
            verticalPadding: 30, horizontalPadding: 20);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Product>(
        'offerSideProducts', widget.offerSideProducts));
    properties.add(IntProperty('offerSideMoney', widget.offerSideMoney));
    properties
        .add(DiagnosticsProperty<Product>('forProduct', widget.forProduct));
    properties.add(StringProperty('tradingID', widget.tradingID));
    properties.add(IntProperty('timeOut', timeOut));
    properties.add(DiagnosticsProperty('referenceDatabase', referenceDatabase));
    properties.add(StringProperty('userID', userID));
    properties.add(StringProperty('otherSideUserID', otherSideUserID));
    properties.add(ColorProperty('statusTextColor', statusTextColor));
    properties.add(StringProperty('dateTime', dateTime));
    properties.add(StringProperty('status', statusText));
    properties.add(IntProperty('status', status));
    properties.add(StringProperty('ownerPostID', ownerPostID));
  }
}
