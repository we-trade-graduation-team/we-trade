import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../app_localizations.dart';
import '../../../models/ui/authentication_features/authentication_error_content.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/helper/flash/flash_helper.dart';
import '../shared_widgets/auth_custom_background.dart';
import '../shared_widgets/custom_form_builder_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  final VoidCallback toggleView;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(ObjectFlagProperty<VoidCallback>.has('toggleView', toggleView));
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
    final _authProvider = context.watch<AuthProvider>();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final node = FocusScope.of(context);

    final _appLocalizations = AppLocalizations.of(context);

    final inputFormChildren = [
      CustomFormBuilderTextField(
        name: 'email',
        labelText: _appLocalizations.translate('registerTxtEmail'),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.email(context),
        ]),
        onEditingComplete: node.nextFocus,
        keyboardType: TextInputType.emailAddress,
        textEditingController: _emailController,
      ),
      CustomFormBuilderTextField(
        name: 'password',
        labelText: _appLocalizations.translate('registerTxtPassword'),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.minLength(context, 6),
        ]),
        obscureText: true,
        onEditingComplete: node.nextFocus,
        textEditingController: _passwordController,
      ),
      CustomFormBuilderTextField(
        name: 'confirm_password',
        labelText: _appLocalizations.translate('registerTxtConfirmPassword'),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.done,
        validator: FormBuilderValidators.compose(
          [
            (val) => val != _formKey.currentState?.fields['password']?.value
                ? _appLocalizations
                    .translate('registerTxtErrorNotMatchPassword')
                : null
          ],
        ),
        obscureText: true,
        onEditingComplete: node.nextFocus,
      ),
      // ! Have a issue, maybe use later
      // FormBuilderCheckbox(
      //   name: 'accept_terms',
      //   initialValue: false,
      //   // onChanged: _onChanged,
      //   activeColor: kPrimaryColor,
      //   title: RichText(
      //     text: const TextSpan(
      //       children: [
      //         TextSpan(
      //           text: 'I have read and agree to the ',
      //           style: TextStyle(color: kTextColor),
      //         ),
      //         TextSpan(
      //           text: 'Terms and Conditions',
      //           style: TextStyle(color: kPrimaryColor),
      //         ),
      //       ],
      //     ),
      //   ),
      //   validator: FormBuilderValidators.equal(
      //     context,
      //     true,
      //     errorText: 'You must accept terms and conditions to continue',
      //   ),
      // ),
    ];

    final footerChildren = [
      Row(
        children: [
          GestureDetector(
            onTap: widget.toggleView,
            child: Text(
              _appLocalizations.translate('registerTxtSignIn'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
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
          //color: Theme.of(context).primaryColor,
        ),
        child: AuthCustomBackground(
          title: _appLocalizations.translate('registerTxtTitle'),
          authFeatureTitle: _appLocalizations.translate('registerTxtSignUp'),
          formKey: _formKey,
          inputFormChildren: inputFormChildren,
          footerChildren: footerChildren,
          onSubmit: () async {
            // start the modal progress HUD
            setState(() {
              _isLoading = true;
            });

            final result = await _authProvider.registerWithEmailAndPassword(
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

            final _appLocalizations = AppLocalizations.of(context);

            final signUpDialogContents = {
              'email-already-in-use': AuthenticationErrorContent(
                title: _appLocalizations
                    .translate('registerAlertTxtErrorEmailAlreadyInUseTitle'),
                content: _appLocalizations
                    .translate('registerAlertTxtErrorEmailAlreadyInUseContent'),
              ),
              'invalid-email': AuthenticationErrorContent(
                title: _appLocalizations
                    .translate('registerAlertTxtErrorInvalidEmailTitle'),
                content: _appLocalizations
                    .translate('registerAlertTxtErrorInvalidEmailContent'),
              ),
              'operation-not-allowed': AuthenticationErrorContent(
                title: _appLocalizations
                    .translate('registerAlertTxtErrorOperationNotAllowedTitle'),
                content: _appLocalizations.translate(
                    'registerAlertTxtErrorOperationNotAllowedContent'),
              ),
              'weak-password': AuthenticationErrorContent(
                title: _appLocalizations
                    .translate('registerAlertTxtErrorWeakPasswordTitle'),
                content: _appLocalizations
                    .translate('registerAlertTxtErrorWeakPasswordContent'),
              ),
            };

            if (result != null) {
              await FlashHelper.showDialogFlash(
                context,
                content: signUpDialogContents[result],
              );
            }
          },
        ),
      ),
    );
  }
}
