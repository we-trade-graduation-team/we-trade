import 'dart:async';
import 'dart:collection';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _MessageItem<T> {
  _MessageItem(this.message) : completer = Completer<Future<T>>();

  final String message;
  Completer<Future<T>> completer;
}

Completer<BuildContext> _buildCompleter = Completer<BuildContext>();
final Queue<_MessageItem> _messageQueue = Queue<_MessageItem>();
Completer? _previousCompleter;

void init(BuildContext context) {
  if (_buildCompleter.isCompleted == false) {
    _buildCompleter.complete(context);
  }
}

void dispose() {
  _messageQueue.clear();

  if (_buildCompleter.isCompleted == false) {
    _buildCompleter.completeError('NotInitialize');
  }
  _buildCompleter = Completer<BuildContext>();
}

Future<T?> toast<T>(String message) async {
  final context = await _buildCompleter.future;

  // Wait previous toast dismissed.
  if (_previousCompleter?.isCompleted == false) {
    final item = _MessageItem<T>(message);
    _messageQueue.add(item);
    return await item.completer.future;
  }

  _previousCompleter = Completer<void>();

  Future<T?> showToast(String message) {
    return showFlash<T>(
      context: context,
      builder: (context, controller) {
        return Flash<void>.dialog(
          controller: controller,
          alignment: const Alignment(0, 0.5),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          // enableDrag: false,
          backgroundColor: Colors.black87,
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 16, color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(message),
            ),
          ),
        );
      },
      duration: const Duration(seconds: 3),
    ).whenComplete(() {
      if (_messageQueue.isNotEmpty) {
        final item = _messageQueue.removeFirst();
        item.completer.complete(showToast(item.message));
      } else {
        _previousCompleter?.complete();
      }
    });
  }

  return showToast(message);
}

Color _backgroundColor(BuildContext context) {
  final theme = Theme.of(context);
  return theme.dialogTheme.backgroundColor ?? theme.dialogBackgroundColor;
}

TextStyle _titleStyle(BuildContext context, [Color? color]) {
  final theme = Theme.of(context);
  return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.headline6)
          ?.copyWith(color: color) ??
      const TextStyle(fontSize: 21, fontWeight: FontWeight.w700);
}

TextStyle _contentStyle(BuildContext context, [Color? color]) {
  final theme = Theme.of(context);
  return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyText2)
          ?.copyWith(color: color) ??
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
}

Future<T?> infoBar<T>(
  BuildContext context, {
  String? title,
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  return showFlash<T>(
    context: context,
    duration: duration,
    builder: (context, controller) {
      return Flash<void>(
        controller: controller,
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        backgroundColor: Colors.black87,
        child: FlashBar(
          title: title == null
              ? null
              : Text(title, style: _titleStyle(context, Colors.white)),
          message: Text(message, style: _contentStyle(context, Colors.white)),
          icon: Icon(Icons.info_outline, color: Colors.green[300]),
          leftBarIndicatorColor: Colors.green[300],
        ),
      );
    },
  );
}

Future<T?> successBar<T>(
  BuildContext context, {
  String? title,
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  return showFlash<T>(
    context: context,
    duration: duration,
    builder: (context, controller) {
      return Flash<void>(
        controller: controller,
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        backgroundColor: Colors.black87,
        child: FlashBar(
          title: title == null
              ? null
              : Text(title, style: _titleStyle(context, Colors.white)),
          message: Text(message, style: _contentStyle(context, Colors.white)),
          icon: Icon(Icons.check_circle, color: Colors.blue[300]),
          leftBarIndicatorColor: Colors.blue[300],
        ),
      );
    },
  );
}

Future<T?> errorBar<T>(
  BuildContext context, {
  String? title,
  required String message,
  ChildBuilder<T>? primaryAction,
  Duration duration = const Duration(seconds: 3),
}) {
  return showFlash<T>(
    context: context,
    duration: duration,
    builder: (context, controller) {
      return StatefulBuilder(builder: (context, setState) {
        return Flash<void>(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            primaryAction: primaryAction?.call(context, controller, setState),
            icon: Icon(Icons.warning, color: Colors.red[300]),
            leftBarIndicatorColor: Colors.red[300],
          ),
        );
      });
    },
  );
}

Future<T?> actionBar<T>(
  BuildContext context, {
  String? title,
  required String message,
  required ChildBuilder<T> primaryAction,
  Duration duration = const Duration(seconds: 3),
}) {
  return showFlash<T>(
    context: context,
    duration: duration,
    builder: (context, controller) {
      return StatefulBuilder(builder: (context, setState) {
        return Flash<void>(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            primaryAction: primaryAction.call(context, controller, setState),
          ),
        );
      });
    },
  );
}

Future<T?> simpleDialog<T>(
  BuildContext context, {
  String? title,
  required String message,
  Color? messageColor,
  ChildBuilder<T>? negativeAction,
  ChildBuilder<T>? positiveAction,
}) {
  return showFlash<T>(
    context: context,
    persistent: false,
    builder: (context, controller) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Flash<void>.dialog(
            controller: controller,
            backgroundColor: _backgroundColor(context),
            margin: const EdgeInsets.only(left: 40, right: 40),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: FlashBar(
              title: title == null
                  ? null
                  : Text(title, style: _titleStyle(context)),
              message:
                  Text(message, style: _contentStyle(context, messageColor)),
              actions: <Widget>[
                if (negativeAction != null)
                  negativeAction(context, controller, setState),
                if (positiveAction != null)
                  positiveAction(context, controller, setState),
              ],
            ),
          );
        },
      );
    },
  );
}

Future<T?> customDialog<T>(
  BuildContext context, {
  ChildBuilder<T>? titleBuilder,
  required ChildBuilder messageBuilder,
  ChildBuilder<T>? negativeAction,
  ChildBuilder<T>? positiveAction,
}) {
  return showFlash<T>(
    context: context,
    persistent: false,
    builder: (context, controller) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Flash<void>.dialog(
            controller: controller,
            backgroundColor: _backgroundColor(context),
            margin: const EdgeInsets.only(left: 40, right: 40),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: FlashBar(
              title: titleBuilder == null
                  ? null
                  : DefaultTextStyle(
                      style: _titleStyle(context),
                      child: titleBuilder.call(context, controller, setState),
                    ),
              message: DefaultTextStyle(
                style: _contentStyle(context),
                child: messageBuilder.call(context, controller, setState),
              ),
              actions: <Widget>[
                if (negativeAction != null)
                  negativeAction(context, controller, setState),
                if (positiveAction != null)
                  positiveAction(context, controller, setState),
              ],
            ),
          );
        },
      );
    },
  );
}

Future<T?> blockDialog<T>(
  BuildContext context, {
  required Completer<T> dismissCompleter,
}) {
  final controller = FlashController<T>(
    context,
    (context, controller) {
      return Flash<void>.dialog(
        controller: controller,
        barrierDismissible: false,
        backgroundColor: Colors.black87,
        margin: const EdgeInsets.only(left: 40, right: 40),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    },
    persistent: false,
    onWillPop: () => Future.value(false),
  );
  dismissCompleter.future.then(controller.dismiss);
  return controller.show();
}

Future<String?> inputDialog(
  BuildContext context, {
  String? title,
  String? message,
  String? defaultValue,
  bool persistent = true,
  WillPopCallback? onWillPop,
}) {
  final editingController = TextEditingController(text: defaultValue);
  return showFlash<String>(
    context: context,
    persistent: persistent,
    onWillPop: onWillPop,
    builder: (context, controller) {
      final theme = Theme.of(context);
      return Flash<String>.bar(
        controller: controller,
        barrierColor: Colors.black54,
        borderWidth: 3,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: FlashBar(
          title: title == null
              ? null
              : Text(title, style: const TextStyle(fontSize: 24)),
          message: Column(
            children: [
              if (message != null) Text(message),
              Form(
                child: TextFormField(
                  controller: editingController,
                  autofocus: true,
                ),
              ),
            ],
          ),
          leftBarIndicatorColor: theme.primaryColor,
          primaryAction: IconButton(
            onPressed: () {
              final message = editingController.text;
              controller.dismiss(message);
            },
            icon: Icon(Icons.send, color: theme.colorScheme.secondary),
          ),
        ),
      );
    },
  );
}

typedef ChildBuilder<T> = Widget Function(
    BuildContext context, FlashController<T> controller, StateSetter setState);
