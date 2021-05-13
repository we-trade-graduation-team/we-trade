import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
// import 'package:flash/flash.dart';
// import 'package:we_trade/services/flash/flash_helper.dart';

import '../../../services/authentication/authentication_service.dart';

// import '../complete_profile_screen/complete_profile_screen.dart';
import '../shared_widgets/auth_custom_background.dart';
import '../shared_widgets/custom_form_builder_text_field.dart';
// import '../sign_in_screen/sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  // static String routeName = '/sign_up';

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

    return Scaffold(
      backgroundColor: Colors.black,
      body: AuthCustomBackground(
        title: 'Sign up and\nstarting trading',
        authFeatureTitle: 'Sign up',
        formKey: _formKey,
        inputFormWidgets: [
          CustomFormBuilderTextField(
            name: 'email',
            labelText: 'Email',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.email(context),
            ]),
            onEditingComplete: node.nextFocus,
            keyboardType: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          CustomFormBuilderTextField(
            name: 'password',
            labelText: 'Password',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.minLength(context, 6),
            ]),
            obscureText: true,
            onEditingComplete: node.nextFocus,
            textEditingController: passwordController,
          ),
          CustomFormBuilderTextField(
            name: 'confirm_password',
            labelText: 'Confirm Password',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            validator: FormBuilderValidators.compose([
              (val) {
                if (val != _formKey.currentState?.fields['password']?.value) {
                  return 'Passwords do not match';
                }
                return null;
              }
            ]),
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
        ],
        footerWidgets: [
          Row(
            children: [
              GestureDetector(
                onTap: widget.toggleView,
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
        navigateCallback: () async {
          // Navigator.pushNamed(context, CompleteProfileScreen.routeName);

          await context.read<AuthenticationService>().signUp(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );

          // final result = await context.read<AuthenticationService>().signUp(
          //       email: emailController.text.trim(),
          //       password: passwordController.text.trim(),
          //     );
          // if (result == null) {
          //   _showDialogFlash();
          // } else {
          //   // print(result.email);
          // }
        },
      ),
    );
  }

  // void _showDialogFlash() {
  //   simpleDialog(
  //     context,
  //     title: 'Incorrect Password',
  //     message: 'The password you entered is incorrect. Please try again',
  //     negativeAction: (_, controller, __) {
  //       return TextButton(
  //         onPressed: () => controller.dismiss(),
  //         child: const Text('OK'),
  //       );
  //     },
  //     // positiveAction: (context, controller, setState) {
  //     //   return TextButton(
  //     //     onPressed: () => controller.dismiss(),
  //     //     child: const Text('YES'),
  //     //   );
  //     // },
  //   );
  // }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'emailController', emailController));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'passwordController', passwordController));
  }
}
