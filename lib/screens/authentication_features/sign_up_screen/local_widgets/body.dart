import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../configs/constants/color.dart';
import '../../complete_profile_screen/complete_profile_screen.dart';
import '../../shared_widgets/auth_custom_background.dart';
import '../../shared_widgets/custom_form_builder_text_field.dart';
import '../../sign_in_screen/sign_in.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return GestureDetector(
      onTap: node.unfocus,
      child: AuthCustomBackground(
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
          ),
          CustomFormBuilderTextField(
            name: 'confirm_password',
            labelText: 'Confirm Password',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            validator: FormBuilderValidators.compose([
              /*FormBuilderValidators.equal(
                            context,
                            _formKey.currentState != null
                                ? _formKey.currentState.fields['password'].value
                                : null),*/
              (val) {
                if (val != _formKey.currentState?.fields['password']?.value) {
                  return 'Passwords do not match';
                }
                return null;
              }
            ]),
            obscureText: true,
            onEditingComplete: node.unfocus,
          ),
          FormBuilderCheckbox(
            name: 'accept_terms',
            initialValue: false,
            // onChanged: _onChanged,
            activeColor: kPrimaryColor,
            title: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'I have read and agree to the ',
                    style: TextStyle(color: kTextColor),
                  ),
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            validator: FormBuilderValidators.equal(
              context,
              true,
              errorText: 'You must accept terms and conditions to continue',
            ),
          ),
        ],
        footerWidgets: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                  context,
                  SignInScreen.routeName,
                ),
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
        navigateCallback: () {
          Navigator.pushNamed(context, CompleteProfileScreen.routeName);
        },
      ),
    );
  }
}
