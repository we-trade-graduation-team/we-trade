import 'package:flutter/material.dart';
import 'package:tiengviet/tiengviet.dart';

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

List<String> splitStr(String str, String pattern) {
  return str.split(pattern);
}

List<String> splitStrList(List listStr) {
  var splitListStr = <String>[];
  for (final item in listStr) {
    final splitComma = splitStr(item.toString(), ',');
    for (final item in splitComma) {
      final splitDot = splitStr(item.toString(), '.');
      splitListStr = <String>[...splitListStr, ...splitDot];
    }
  }
  return splitListStr;
}

bool checkIfContains(List listStr, String str) {
  for (final item in listStr) {
    if (item.trim() == '') {
      continue;
    }
    if (TiengViet.parse(str.toLowerCase())
        .contains(TiengViet.parse(item.toString().trim().toLowerCase()))) {
      return true;
    }
  }
  return false;
}
