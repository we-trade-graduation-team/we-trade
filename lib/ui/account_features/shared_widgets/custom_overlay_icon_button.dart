import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'trading_prod_overlay.dart';

class CustomOverlayIconButton extends StatelessWidget {
  const CustomOverlayIconButton(
      {Key? key, required this.iconData, required this.overlayItems})
      : super(key: key);

  final IconData iconData;
  final List<OverlayItem> overlayItems;

  void showOverlay({required BuildContext context}) {
    BotToast.showAttachedWidget(
      attachedBuilder: (_) => TradingProdOverlay(overlayItems: overlayItems),
      //duration: const Duration(seconds: 2),
      targetContext: context,
      preferDirection: PreferDirection.bottomRight,
      //target: const Offset(200, 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: () => showOverlay(context: context),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<IconData>('iconData', iconData));
  }
}
