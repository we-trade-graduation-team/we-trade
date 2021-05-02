import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.menuScreenContext,
    required this.onScreenHideButtonPressed,
    required this.hideStatus,
  }) : super(key: key);

  static String routeName = '/home';
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BuildContext>(
        'menuScreenContext', menuScreenContext));
    properties.add(DiagnosticsProperty<Function>(
        'onScreenHideButtonPressed', onScreenHideButtonPressed));
    properties.add(DiagnosticsProperty<bool>('hideStatus', hideStatus));
  }
}
