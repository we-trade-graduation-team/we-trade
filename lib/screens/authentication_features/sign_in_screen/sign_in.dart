import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants/assets_paths/sign_in_screen_assets_path.dart';
import '../../../services/authentication/authentication_service.dart';
import '../../../services/authentication/dialog_contents/sign_in_dialog_content.dart';
import '../../../services/authentication/progress_indicator.dart';
import '../../../services/authentication/show_dialog_flash.dart';
import '../forgot_password_screen/forgot_password_screen.dart';
import '../shared_widgets/auth_custom_background.dart';
import '../shared_widgets/custom_form_builder_text_field.dart';
import '../shared_widgets/rounded_icon_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  // static String routeName = '/sign_in';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormBuilderState>? formKey = GlobalKey<FormBuilderState>();
  // final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  // manage state of modal progress HUD widget
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final node = FocusScope.of(context);

    final socialIcons = [
      googleIcon,
      appleIcon,
      facebookIcon,
    ];

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
            child: const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              ForgotPasswordScreen.routeName,
            ),
            child: const Text(
              'Forgot password?',
              style: TextStyle(
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
        labelText: 'Email address',
        validator: _validateEmail(context),
        onEditingComplete: node.nextFocus,
        keyboardType: TextInputType.emailAddress,
        textEditingController: emailController,
      ),
      CustomFormBuilderTextField(
        name: 'password',
        labelText: 'Password',
        validator: _validatePassword(context),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onEditingComplete: node.nextFocus,
        textEditingController: passwordController,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.white,
        opacity: 1,
        // progressIndicator: const SpinKitCircle(
        //   color: kPrimaryColor,
        // ),
        progressIndicator: progressIndicator,
        child: AuthCustomBackground(
          title: 'Welcome\nBack',
          authFeatureTitle: 'Sign in',
          formKey: formKey,
          inputFormChildren: inputFormChildren,
          footerChildren: footerChildren,
          onSubmit: _submit,
        ),
      ),
    );
  }

  Future<void> _submit() async {
    // start the modal progress HUD
    setState(() {
      _isLoading = true;
    });

    final result = await context.read<AuthenticationService>().signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

    if (!mounted) {
      return;
    }

    // stop the modal progress HUD
    setState(() {
      _isLoading = false;
    });

    if (result != null) {
      // print(signInDialogContents[result]);
      showDialogFlash(
        context,
        content: signInDialogContents[result],
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'emailController', emailController));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'passwordController', passwordController));
    properties.add(
        DiagnosticsProperty<GlobalKey<FormBuilderState>?>('formKey', formKey));
  }
}
