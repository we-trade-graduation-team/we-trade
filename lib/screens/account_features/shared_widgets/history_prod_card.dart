import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
import '../../../models/product/temp_class.dart';
import '../../../models/review/temp_class.dart';
import '../../../screens/account_features/trading_history/rate_for_trading.dart';
import 'custom_overlay_icon_button.dart';
import 'trading_prod_overlay.dart';

class HistoryProductCard extends StatelessWidget {
  const HistoryProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final overlayItems = <OverlayItem>[
      OverlayItem(
        text: 'Đánh giá',
        iconData: Icons.star,
        handleFunction: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(name: RateForTrading.routeName),
            screen: const RateForTrading(),
            // withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
          // Navigator.of(context).pushNamed(RateForTrading.routeName);
        },
      ),
      OverlayItem(
        text: 'Xóa',
        iconData: Icons.delete,
        handleFunction: () {
          // print('Delete trading history');
        },
      ),
    ];

    return GestureDetector(
      onTap: () {
        // print('product tapped');
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          //color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: kTextColor,
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
                  width: width * 0.26,
                  height: height * 0.15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      productsData[0].images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.45,
                      child: Text(
                        productsData[0].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      width: width * 0.45,
                      child: Text(
                        reviewsData[0].dateTime.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: const [
                        Text(
                          'TK giao dich: ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'User',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: const [
                        Text(
                          'Trạng thái: ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Thành công',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CustomOverlayIconButton(
                    iconData: Icons.more_vert, overlayItems: overlayItems),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
