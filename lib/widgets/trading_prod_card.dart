import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../configs/constants/color.dart';
import '../models/review/temp_class.dart';
import '../screens/post_management/hide_post_screen.dart';
import '../widgets/trading_prod_overlay.dart';
import './custom_overlay_iconbutton.dart';

class TradingProductCard extends StatelessWidget {
  const TradingProductCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  // ignore: diagnostic_describe_all_properties
  final Review review;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final overlayItems = <OverlayItem>[
      OverlayItem(
        text: 'Ẩn tin',
        iconData: Icons.visibility_off,
        // ignore: avoid_types_on_closure_parameters
        handleFunction: () {
          Navigator.of(context).pushNamed(HidePostScreen.routeName);
        },
      ),
    ];

    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print('product tapped');
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 3, 15, 3),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: const BoxDecoration(
          //color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: kTextLightV2Color,
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
                      // ignore: use_raw_strings
                      '\$200-\$300',
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
}