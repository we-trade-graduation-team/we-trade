import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/helper/flash/flash_helper.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(onBackPressed);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(onBackPressed);
    super.dispose();
  }

  // ignore: avoid_positional_boolean_parameters
  bool onBackPressed(bool stopDefaultButtonEvent, RouteInfo routeInfo) {
    // print("BACK BUTTON!"); // Do some stuff.
    // Handle android back event here. WillPopScope is not recommended.
    return false;
  }

  // manage state of modal progress HUD widget
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final _appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      key: _key,
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.white,
        opacity: 1,
        progressIndicator: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              // color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              _appLocalizations.translate('logoutFlashTxtLoggingOut'),
            ),
          ],
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 50,
                  width: _size.width,
                  child: ElevatedButton(
                    onPressed: onSignOutPressed,
                    child: Text(
                      _appLocalizations.translate('logoutTxtSignOut'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSignOutPressed() async {
    final _appLocalizations = AppLocalizations.of(context);

    // Show dialog Ok-Cancel
    await FlashHelper.showDialogFlash(
      context,
      title: Text(_appLocalizations.translate('logoutAlertTxtTitle')),
      content: Text(_appLocalizations.translate('logoutAlertTxtContent')),
      showBothAction: true,
      onOKPressed: signOut,
    );
  }

  Future<void> signOut() async {
    final _authProvider = context.read<AuthProvider>();

    final _appLocalizations = AppLocalizations.of(context);

    // start the modal progress HUD
    setState(() {
      _isLoading = true;
    });

    const secondsDelay = 1;

    await Future.wait([
      // Delay to show flash
      Future<void>.delayed(const Duration(seconds: secondsDelay)),
      // Show flash
      FlashHelper.showBasicsFlash(
        context,
        message: _appLocalizations.translate('logoutAlertTxtLoggedOut'),
        duration: const Duration(seconds: secondsDelay * 2),
      ),
    ]);

    await _authProvider.signOut();

    if (!mounted) {
      return;
    }

    await Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);

    // stop the modal progress HUD
    setState(() {
      _isLoading = false;
    });
  }
}
