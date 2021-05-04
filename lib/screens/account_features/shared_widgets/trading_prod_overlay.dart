import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';

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
  const OverlayItem({
    Key? key,
    required this.text,
    required this.iconData,
    required this.handleFunction,
  }) : super(key: key);

  final String text;

  final IconData iconData;

  final Function handleFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleFunction,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
    properties.add(DiagnosticsProperty<IconData>('iconData', iconData));
    properties
        .add(DiagnosticsProperty<Function>('handleFunction', handleFunction));
  }
}
