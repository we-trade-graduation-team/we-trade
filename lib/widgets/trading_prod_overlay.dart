import 'package:flutter/material.dart';
import '../configs/constants/color.dart';

class TradingProdOverlay extends StatelessWidget {
  const TradingProdOverlay({Key? key, required this.overlayItems})
      : super(key: key);
//  final double itemHeight;
  final List<OverlayItem> overlayItems;

  @override
  Widget build(BuildContext context) {
    final widthOfOverlay = MediaQuery.of(context).size.width * 0.38 > 220.0
        ? 220.0
        : MediaQuery.of(context).size.width * 0.38;
    const heightOfOverlayItem = 40.0;

    return Material(
      elevation: 25,
      child: Container(
        height: overlayItems.length *
            (heightOfOverlayItem + 6), //change when overflowed
        // height: 200,
        width: widthOfOverlay,

        child: Column(
          children: [
            ...overlayItems,
          ],
        ),
      ),
    );
  }
}

class OverlayItem extends StatelessWidget {
  // ignore: diagnostic_describe_all_properties
  final String text;
  // ignore: diagnostic_describe_all_properties
  final IconData iconData;
  // ignore: diagnostic_describe_all_properties
  final Function handleFunction;

  // ignore: sort_constructors_first
  const OverlayItem({
    Key? key,
    required this.text,
    required this.iconData,
    required this.handleFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: unnecessary_lambdas
      onTap: () {
        handleFunction();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                // const Spacer(),
                Expanded(
                  flex: 2,
                  child: Icon(iconData),
                ),
              ],
            ),
            const Divider(
              color: kTextColor,
            )
          ],
        ),
      ),
    );
  }
}
