import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../configs/constants/assets_path.dart';
import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/strings.dart';
// import '../../../../utils/helpers/keyboard.dart';
import '../../../../widgets/custom_suffix_icon.dart';
import '../../../../widgets/default_button.dart';
import '../../../../widgets/form_error.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../login_success/login_success_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // SizedBox(
          //   width: size.width * 0.8,
          //   child: buildEmailFormField(),
          // ),
          buildEmailFormField(),
          SizedBox(height: size.height * 0.03),
          buildPasswordFormField(),
          // SizedBox(
          //   width: size.width * 0.8,
          //   child: buildPasswordFormField(),
          // ),
          SizedBox(height: size.height * 0.03),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              const Text(kRememberMe),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  kForgotPassword,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: size.height * 0.02),
          DefaultButton(
            text: kSignInButton,
            press: () => Navigator.pushNamed(
              context,
              LoginSuccessScreen.routeName,
            ),
            // press: () {
            //   if (_formKey.currentState!.validate()) {
            //     _formKey.currentState!.save();
            //     // if all are valid then go to success screen
            //     KeyboardUtil.hideKeyboard(context);
            //     Navigator.pushNamed(context, LoginSuccessScreen.routeName);
            //   }
            // },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return '';
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return '';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: kPasswordLabel,
        hintText: kPassworkHint,
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: lockIcon,
        ),
        // border: InputBorder.none,
        // focusedBorder: InputBorder.none,
        // enabledBorder: InputBorder.none,
        // errorBorder: InputBorder.none,
        // disabledBorder: InputBorder.none,
        // contentPadding:
        //     EdgeInsets.only(left: 40, bottom: 11, top: 11, right: 15),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return '';
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return '';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: kEmailLabel,
        hintText: kEmailHint,
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: mailIcon,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('email', email));
    properties.add(StringProperty('password', password));
    properties.add(DiagnosticsProperty<bool>('remember', remember));
    properties.add(IterableProperty<String>('errors', errors));
  }
}
