import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
import '../../../models/review/temp_class.dart';
import '../../../screens/account_features/post_management/hide_post_screen.dart';
import 'custom_overlay_icon_button.dart';
import 'trading_prod_overlay.dart';

class TradingProductCard extends StatelessWidget {
  const TradingProductCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final overlayItems = <OverlayItem>[
      OverlayItem(
        text: 'Ẩn tin',
        iconData: Icons.visibility_off,
        handleFunction: () {
          pushNewScreenWithRouteSettings<void>(
            context,
            settings: const RouteSettings(name: HidePostScreen.routeName),
            screen: const HidePostScreen(),
            // withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
          // Navigator.of(context).pushNamed(HidePostScreen.routeName);
        },
      ),
    ];

    return GestureDetector(
      onTap: () {
        // print('product tapped');
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 3, 15, 3),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.26,
                  height: height * 0.15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      review.product.images[0],
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
                      child: const Text(
                        'LApTop moiw 12 12sqwrqwq eqweqwe qweqt qwrqmua2121212121222121qwq qwxcvf',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      r'$200-$300',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                CustomOverlayIconButton(
                  iconData: Icons.more_vert,
                  overlayItems: overlayItems,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  review.dateTime.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
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
    properties.add(DiagnosticsProperty<Review>('review', review));
  }
}
