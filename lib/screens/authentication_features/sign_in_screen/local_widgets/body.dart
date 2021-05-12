import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../configs/constants/assets_paths/sign_in_screen_assets_path.dart';
import '../../../../services/authentication_service.dart';
import '../../forgot_password_screen/forgot_password_screen.dart';
import '../../shared_widgets/auth_custom_background.dart';
import '../../shared_widgets/custom_form_builder_text_field.dart';
import '../../shared_widgets/rounded_icon_button.dart';
import '../../sign_up_screen/sign_up.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final socialIcons = [
      googleIcon,
      appleIcon,
      facebookIcon,
    ];
    return AuthCustomBackground(
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
          onEditingComplete: node.unfocus,
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
              onTap: () => Navigator.pushReplacementNamed(
                context,
                SignUpScreen.routeName,
              ),
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
        final result = await context.read<AuthenticationService>().signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
        if (result == null) {
          print('error');
        } else {
          print(result.email);
        }
        // Navigator.of(context).pushAndRemoveUntil<void>(
        //   MaterialPageRoute(
        //     settings: const RouteSettings(
        //       name: '/',
        //     ),
        //     builder: (context) => MainMenu(
        //       menuScreenContext: context,
        //     ),
        //   ),
        //   (route) => false,
        // );
      },
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
