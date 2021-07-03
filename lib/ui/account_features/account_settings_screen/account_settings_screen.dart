import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
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
    BackButtonInterceptor.add((_, __) => false);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove((_, __) => false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final _appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      key: _key,
      body: SafeArea(
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
    );
  }

  Future<void> onSignOutPressed() async {
    final _appLocalizations = AppLocalizations.of(context);

    // Show dialog Ok-Cancel
    return FlashHelper.showDialogFlash(
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
  }
}
