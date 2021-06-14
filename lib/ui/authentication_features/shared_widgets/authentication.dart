import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../sign_in_screen/sign_in_screen.dart';
import '../sign_up_screen/sign_up_screen.dart';

class Authentication extends StatefulWidget {
  const Authentication({
    Key? key,
  }) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool _showSignIn = true;

  void toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (_) {
            return _showSignIn
                ? SignInScreen(toggleView: toggleView)
                : SignUpScreen(toggleView: toggleView);
          },
        ),
      ],
    );
  }
}
