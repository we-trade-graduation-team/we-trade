import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/flash/flash_helper.dart' as flash_helper;
import '../../models/authentication/authentication_error_content.dart';

void showDialogFlash(
  BuildContext context, {
  AuthenticationErrorContent? content,
}) {
  flash_helper.simpleDialog(
    context,
    title: content?.title,
    message: content != null ? content.message : 'Something went wrong',
    negativeAction: (_, controller, __) {
      return TextButton(
        onPressed: () => controller.dismiss(),
        child: const Text('OK'),
      );
    },
  );
}
