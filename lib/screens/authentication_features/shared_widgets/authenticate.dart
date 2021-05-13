import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../services/flash/flash_helper.dart' as flash_helper;
import '../sign_in_screen/sign_in.dart';
import '../sign_up_screen/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({
    Key? key,
  }) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  void dispose() {
    flash_helper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    flash_helper.init(context);

    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (_) {
            return showSignIn
                ? SignInScreen(toggleView: toggleView)
                : SignUpScreen(toggleView: toggleView);
          },
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('showSignIn', showSignIn));
  }
}
