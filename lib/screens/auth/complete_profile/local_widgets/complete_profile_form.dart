import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/assets_path.dart';
import '../../../../configs/constants/strings.dart';
import '../../../../widgets/custom_suffix_icon.dart';
import '../../../../widgets/default_button.dart';
import '../../../../widgets/form_error.dart';
import '../../otp/otp_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String address;

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
          buildFirstNameFormField(),
          SizedBox(height: size.height * 0.03),
          buildLastNameFormField(),
          SizedBox(height: size.height * 0.03),
          buildPhoneNumberFormField(),
          SizedBox(height: size.height * 0.03),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: size.height * 0.04),
          DefaultButton(
            text: kCompleteProfileButton,
            press: () => Navigator.pushNamed(
              context,
              OtpScreen.routeName,
            ),
            // press: () {
            //   if (_formKey.currentState!.validate()) {
            //     Navigator.pushNamed(context, OtpScreen.routeName);
            //   }
            // },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return '';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: kAddressLabel,
        hintText: kAddressHint,
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: locationIcon,
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return '';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: kPhoneNumberLabel,
        hintText: kPhoneNumberHint,
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: phoneIcon,
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue!,
      decoration: const InputDecoration(
        labelText: kLastNameLabel,
        hintText: kLastNameHint,
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: userIcon,
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return '';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: kFirstNameLabel,
        hintText: kFirstNameHint,
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: userIcon,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('errors', errors));
    properties.add(StringProperty('firstName', firstName));
    properties.add(StringProperty('lastName', lastName));
    properties.add(StringProperty('phoneNumber', phoneNumber));
    properties.add(StringProperty('address', address));
  }
}
