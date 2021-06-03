import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/ui/authentication_features/authentication_error_content.dart';

class FlashHelper {
  FlashHelper._();

  static Future<void> showDialogFlash(
    BuildContext context, {
    bool persistent = true,
    // required BuildContext context,
    required AuthenticationErrorContent? content,
  }) async {
    await context.showFlashDialog(
      persistent: persistent,
      title: content != null ? Text(content.title) : null,
      content:
          Text(content != null ? content.content : 'Some thing went wrong'),
      negativeActionBuilder: (_, controller, __) {
        return TextButton(
          onPressed: () {
            controller.dismiss();
          },
          child: const Text('OK'),
        );
      },
    );
  }

  static Future<void> showBasicsFlash(
    BuildContext context, {
    // required BuildContext context,
    required String message,
    Duration? duration,
    FlashBehavior flashStyle = FlashBehavior.floating,
    Color backgroundColor = Colors.black,
  }) async {
    await showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash<void>(
          controller: controller,
          behavior: flashStyle,
          position: FlashPosition.bottom,
          backgroundColor: backgroundColor,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
