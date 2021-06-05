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

Future<void> showMyConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function onConfirmFunction,
  required Function onCancelFunction,
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
        actions: [
          TextButton(
            onPressed: () {
              onConfirmFunction();
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              onCancelFunction();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Future<void> showMyPickerMethodDialog({
  required BuildContext context,
  required String mainTitle,
  required String fromGalleryTitle,
  required Function fromGalleryHandler,
  required String fromCameraTitle,
  required Function fromCameraHandler,
}) async {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        // title: Text('Chọn ảnh từ'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(mainTitle),
              TextButton(
                onPressed: () {
                  fromGalleryHandler();
                  Navigator.of(context).pop();
                },
                child: Text(fromGalleryTitle),
              ),
              TextButton(
                onPressed: () {
                  fromCameraHandler();
                  Navigator.of(context).pop();
                },
                child: Text(fromCameraTitle),
              ),
            ],
          ),
        ),
      );
    },
  );
}
