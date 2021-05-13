import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants/assets_paths/sign_in_screen_assets_path.dart';
import '../../../services/authentication/authentication_service.dart';
import '../../../services/flash/flash_helper.dart' as flash_helper;
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
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

    return Scaffold(
      backgroundColor: Colors.black,
      body: AuthCustomBackground(
        title: 'Welcome\nBack',
        authFeatureTitle: 'Sign in',
        formKey: _formKey,
        inputFormWidgets: [
          CustomFormBuilderTextField(
            name: 'email',
            labelText: 'Email address',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.email(context),
            ]),
            onEditingComplete: node.nextFocus,
            keyboardType: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          // const SizedBox(height: 20),
          CustomFormBuilderTextField(
            name: 'password',
            labelText: 'Password',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.minLength(context, 6),
            ]),
            obscureText: true,
            textInputAction: TextInputAction.done,
            onEditingComplete: node.nextFocus,
            textEditingController: passwordController,
          ),
        ],
        footerWidgets: [
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
        ],
        navigateCallback: () async {
          // await context.read<AuthenticationService>().signIn(
          //       email: emailController.text.trim(),
          //       password: passwordController.text.trim(),
          //     );
          final result = await context.read<AuthenticationService>().signIn(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
          if (result == null) {
            _showDialogFlash();
          }
        },
      ),
    );
  }

  void _showDialogFlash() {
    flash_helper.simpleDialog(
      context,
      title: 'Incorrect Password',
      message: 'The password you entered is incorrect. Please try again',
      negativeAction: (_, controller, __) {
        return TextButton(
          onPressed: () => controller.dismiss(),
          child: const Text('OK'),
        );
      },
      // positiveAction: (context, controller, setState) {
      //   return TextButton(
      //     onPressed: () => controller.dismiss(),
      //     child: const Text('YES'),
      //   );
      // },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'emailController', emailController));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'passwordController', passwordController));
  }
}
