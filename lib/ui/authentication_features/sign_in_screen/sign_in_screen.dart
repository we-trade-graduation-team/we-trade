import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../app_localizations.dart';
import '../../../constants/app_assets.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/helper/authentication/dialog_content_helper/dialog_content_helper.dart';
import '../../../utils/helper/flash/flash_helper.dart';
import '../../../utils/routes/routes.dart';
import '../shared_widgets/auth_custom_background.dart';
import '../shared_widgets/custom_form_builder_text_field.dart';
import '../shared_widgets/rounded_icon_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  final VoidCallback toggleView;

  @override
  _SignInScreenState createState() => _SignInScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(ObjectFlagProperty<VoidCallback>.has('toggleView', toggleView));
  }
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // manage state of modal progress HUD widget
  bool _isLoading = false;

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
    // Handle android back event here. WillPopScope is not recommended.
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final node = FocusScope.of(context);

    final socialIcons = [
      AppAssets.googleIcon,
      AppAssets.appleIcon,
      AppAssets.facebookIcon,
    ];

    final _appLocalizations = AppLocalizations.of(context);

    final footerChildren = [
      Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: socialIcons
              .map(
                (icon) => RoundedIconButton(
                  icon: SvgPicture.asset(
                    icon,
                    height: 25,
                    width: 25,
                    placeholderBuilder: (context) => Container(
                      padding: const EdgeInsets.all(30),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                  elevation: 2,
                  width: 50,
                  onPressed: () {},
                ),
              )
              .toList(),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: widget.toggleView,
            child: Text(
              _appLocalizations.translate('loginTxtSignUp'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.forgotPasswordScreenRouteName,
            ),
            child: Text(
              _appLocalizations.translate('loginTxtForgotPassword'),
              style: const TextStyle(
                // fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    ];

    final inputFormChildren = [
      CustomFormBuilderTextField(
        name: 'email',
        labelText: _appLocalizations.translate('loginTxtEmail'),
        validator: _validateEmail(context),
        onEditingComplete: node.nextFocus,
        keyboardType: TextInputType.emailAddress,
        textEditingController: _emailController,
      ),
      CustomFormBuilderTextField(
        name: 'password',
        labelText: _appLocalizations.translate('loginTxtPassword'),
        validator: _validatePassword(context),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onEditingComplete: node.nextFocus,
        textEditingController: _passwordController,
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      // display modal progress HUD (heads-up display, or indicator)
      // when in async call
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.white,
        opacity: 1,
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
        child: AuthCustomBackground(
          title: _appLocalizations.translate('loginTxtTitle'),
          authFeatureTitle: _appLocalizations.translate('loginTxtSignIn'),
          formKey: _formKey,
          inputFormChildren: inputFormChildren,
          footerChildren: footerChildren,
          onSubmit: signIn,
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final _authProvider = context.read<AuthProvider>();

    // start the modal progress HUD
    setState(() {
      _isLoading = true;
    });

    final result = await _authProvider.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    // stop the modal progress HUD
    setState(() {
      _isLoading = false;
    });

    if (result != null) {
      final _appLocalizations = AppLocalizations.of(context);

      final _contentHelper = DialogContentHelper(_appLocalizations);

      final signInDialogContents = _contentHelper.signInDialogContents;

      final myDialogContent = signInDialogContents[result];

      final dialogTitleText = myDialogContent != null
          ? myDialogContent.title
          : _appLocalizations.translate('authenticationAlertTxtErrorTitle');

      final dialogContentText = myDialogContent != null
          ? myDialogContent.content
          : _appLocalizations.translate('authenticationAlertTxtErrorContent');

      await FlashHelper.showDialogFlash(
        context,
        title: Text(dialogTitleText),
        content: Text(dialogContentText),
        showBothAction: false,
      );
    }
  }

  FormFieldValidator<String> _validatePassword(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(context),
      FormBuilderValidators.minLength(context, 6),
    ]);
  }

  FormFieldValidator<String> _validateEmail(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(context),
      FormBuilderValidators.email(context),
    ]);
  }
}
