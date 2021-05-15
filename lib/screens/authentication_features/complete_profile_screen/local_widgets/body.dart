import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../otp_screen/otp_screen.dart';
import '../../shared_widgets/auth_custom_background.dart';
import '../../shared_widgets/custom_form_builder_text_field.dart';

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
    final node = FocusScope.of(context);
    return AuthCustomBackground(
      title: 'Complete\nprofile',
      authFeatureTitle: 'Complete profile',
      formKey: _formKey,
      inputFormChildren: [
        CustomFormBuilderTextField(
          name: 'first_name',
          labelText: 'First name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
          onEditingComplete: node.nextFocus,
          keyboardType: TextInputType.name,
        ),
        CustomFormBuilderTextField(
          name: 'last_name',
          labelText: 'Last name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
          onEditingComplete: node.nextFocus,
          keyboardType: TextInputType.name,
        ),
        CustomFormBuilderTextField(
          name: 'phone_number',
          labelText: 'Phone number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
            FormBuilderValidators.minLength(context, 10),
          ]),
          onEditingComplete: node.nextFocus,
          keyboardType: TextInputType.phone,
        ),
        CustomFormBuilderTextField(
          name: 'address',
          labelText: 'Address',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
          onEditingComplete: node.unfocus,
          keyboardType: TextInputType.streetAddress,
        ),
      ],
      onSubmit: () {
        Navigator.pushNamed(context, OtpScreen.routeName);
      },
    );
  }
}
