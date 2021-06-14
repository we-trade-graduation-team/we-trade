import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../../../app_localizations.dart';

class FlashHelper {
  FlashHelper._();

  static Future<void> showDialogFlash(
    BuildContext context, {
    required Widget content,
    required bool showBothAction,
    bool persistent = true,
    Widget? title,
    void Function()? onOKPressed,
  }) async {
    final _appLocalizations = AppLocalizations.of(context);

    await context.showFlashDialog(
      persistent: persistent,
      title: title,
      content: content,
      negativeActionBuilder: (_, controller, __) {
        return TextButton(
          onPressed: () {
            if (showBothAction && onOKPressed != null) {
              onOKPressed();
            }
            controller.dismiss();
          },
          child: Text(
            showBothAction
                ? _appLocalizations.translate('alertDialogOkBtn')
                : _appLocalizations.translate('alertDialogCancelBtn'),
          ),
        );
      },
      positiveActionBuilder: (_, controller, __) {
        return showBothAction
            ? TextButton(
                onPressed: () {
                  controller.dismiss();
                },
                child: Text(
                  _appLocalizations.translate('alertDialogCancelBtn'),
                ),
              )
            : Container();
      },
    );
  }

  static Future<void> showBasicsFlash(
    BuildContext context, {
    required String message,
    FlashBehavior flashStyle = FlashBehavior.floating,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    FlashPosition position = FlashPosition.bottom,
    HorizontalDismissDirection horizontalDismissDirection =
        HorizontalDismissDirection.horizontal,
    Duration? duration,
  }) async {
    await showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash<void>(
          controller: controller,
          behavior: flashStyle,
          position: position,
          backgroundColor: backgroundColor,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: horizontalDismissDirection,
          child: FlashBar(
            content: Text(
              message,
              style: TextStyle(color: textColor),
            ),
          ),
        );
      },
    );
  }
}
