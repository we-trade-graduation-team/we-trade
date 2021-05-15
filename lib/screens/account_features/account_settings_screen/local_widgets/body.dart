import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../../configs/constants/color.dart';
import '../../../../services/authentication/authentication_service.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // manage state of modal progress HUD widget
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LoadingOverlay(
      isLoading: _isLoading,
      color: Colors.white,
      opacity: 1,
      progressIndicator: const CircularProgressIndicator(
        color: kPrimaryColor,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: 50,
                width: size.width,
                child: ElevatedButton(
                  onPressed: signedOut,
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  child: const Text('Sign out'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signedOut() async {
    // start the modal progress HUD
    setState(() {
      _isLoading = true;
    });

    await Future<void>.delayed(const Duration(seconds: 3));

    await context.read<AuthenticationService>().signOut();

    await Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

    if (!mounted) {
      return;
    }

    // stop the modal progress HUD
    setState(() {
      _isLoading = false;
    });

    _showBasicsFlash(
      message: 'Logged out',
    );
  }

  void _showBasicsFlash({
    required String message,
    Duration? duration,
    FlashStyle? flashStyle = FlashStyle.floating,
    Color backgroundColor = Colors.black,
  }) {
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash<void>(
          controller: controller,
          style: flashStyle,
          // boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: backgroundColor,
          child: FlashBar(
            message: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
