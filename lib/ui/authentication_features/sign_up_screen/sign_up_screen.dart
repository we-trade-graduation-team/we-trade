import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/helper/authentication/dialog_content_helper/dialog_content_helper.dart';
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
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // manage state of modal progress HUD widget
  bool _isLoading = false;

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
        textEditingController: _confirmPasswordController,
      ),
      CustomFormBuilderTextField(
        name: 'name',
        labelText: _appLocalizations.translate('registerTxtName'),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.minLength(context, 4),
          FormBuilderValidators.maxLength(context, 20),
        ]),
        onEditingComplete: node.nextFocus,
        textEditingController: _nameController,
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
        // progressIndicator: const CircularProgressIndicator(
        //   //color: Theme.of(context).primaryColor,
        // ),
        child: AuthCustomBackground(
          title: _appLocalizations.translate('registerTxtTitle'),
          authFeatureTitle: _appLocalizations.translate('registerTxtSignUp'),
          formKey: _formKey,
          inputFormChildren: inputFormChildren,
          footerChildren: footerChildren,
          onSubmit: signUp,
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final _authProvider = context.read<AuthProvider>();

    // start the modal progress HUD
    setState(() {
      _isLoading = true;
    });

    final result = await _authProvider.registerWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    // stop the modal progress HUD
    setState(() {
      _isLoading = false;
    });

    if (result == null) {
      return;
    }

    final _appLocalizations = AppLocalizations.of(context);

    final _contentHelper = DialogContentHelper(_appLocalizations);

    final signUpDialogContents = _contentHelper.signUpDialogContents;

    final myDialogContent = signUpDialogContents[result];

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
