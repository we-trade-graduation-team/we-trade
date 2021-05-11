import 'package:flutter/material.dart';

Future<void> showMyNotificationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function handleFunction,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(content),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              handleFunction();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
