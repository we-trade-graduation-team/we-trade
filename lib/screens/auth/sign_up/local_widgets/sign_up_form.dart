import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/assets_path.dart';

import '../../../../configs/constants/strings.dart';
import '../../../../widgets/custom_suffix_icon.dart';
import '../../../../widgets/default_button.dart';
import '../../../../widgets/form_error.dart';
import '../../complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;
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
          buildConformPassFormField(),
          // SizedBox(
          //   width: size.width * 0.9,
          //   child: buildConformPassFormField(),
          // ),
          //buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: size.height * 0.03),
          DefaultButton(
            text: kSignUpButton,
            press: () => Navigator.pushNamed(
              context,
              CompleteProfileScreen.routeName,
            ), // press: () {
            //   if (_formKey.currentState!.validate()) {
            //     _formKey.currentState!.save();
            //     // if all are valid then go to success screen
            //     Navigator.pushNamed(context, CompleteProfileScreen.routeName);
            //   }
            // },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return '';
        } else if (password != value) {
          addError(error: kMatchPassError);
          return '';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: kConfirmPasswordLabel,
        hintText: kConfirmPasswordHint,
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: lockIcon,
        ),
        contentPadding:
            EdgeInsets.only(left: 40, bottom: 20, top: 20, right: 15),
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
        password = value;
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
    properties.add(StringProperty('confirmPassword', confirmPassword));
  }
}
