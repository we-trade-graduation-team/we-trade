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

  // manage state of modal progress HUD widget
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _authProvider = context.read<AuthProvider>();

    final size = MediaQuery.of(context).size;

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
              //color: Theme.of(context).primaryColor,
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
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      // start the modal progress HUD
                      setState(() {
                        _isLoading = true;
                      });

                      const secondsDelay = 1;

                      await Future<void>.delayed(
                          const Duration(seconds: secondsDelay));

                      // final _appLocalizations = AppLocalizations.of(context);
                      await FlashHelper.showBasicsFlash(
                        context,
                        message: _appLocalizations
                            .translate('logoutAlertTxtLoggedOut'),
                        duration: const Duration(seconds: secondsDelay * 2),
                      );

                      await _authProvider.signOut();

                      await Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (_) => false);

                      // Navigator.pop(context);

                      // await Navigator.of(context).pushNamedAndRemoveUntil(
                      //   Routes.authenticationRouteName,
                      //   ModalRoute.withName(Routes.authenticationRouteName),
                      // );

                      if (!mounted) {
                        return;
                      }

                      // stop the modal progress HUD
                      setState(() {
                        _isLoading = false;
                      });
                    },
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
}
