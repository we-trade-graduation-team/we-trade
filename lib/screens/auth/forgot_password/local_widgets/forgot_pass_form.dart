simport 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../configs/constants/assets_path.dart';
import '../../../../configs/constants/strings.dart';
import '../../../../widgets/custom_suffix_icon.dart';
import '../../../../widgets/default_button.dart';
import '../../../../widgets/form_error.dart';
import '../../../../widgets/no_account_text.dart';
import '../../../home/home_screen.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: kEmailLabel,
              hintText: kEmailHint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(
                svgIcon: mailIcon,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          FormError(errors: errors),
          SizedBox(height: size.height * 0.1),
          DefaultButton(
            text: kForgotPasswordButton,
            press: () => Navigator.pushNamed(
              context,
              HomeScreen.routeName,
            ),
            // press: () {
            //   if (_formKey.currentState!.validate()) {
            //     // Do what you want to do
            //   }
            // },
          ),
          SizedBox(height: size.height * 0.1),
          const NoAccountText(),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('errors', errors));
    properties.add(StringProperty('email', email));
  }
}
