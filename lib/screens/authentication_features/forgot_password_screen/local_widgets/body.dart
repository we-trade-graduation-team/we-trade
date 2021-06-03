import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../configs/constants/color.dart';
import '../../../../main_menu.dart';
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
    final size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return AuthCustomBackground(
      title: 'Forgot\npassword',
      authFeatureTitle: 'Forgot password',
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
        ),
      ],
      titleGuide: Container(
        margin: EdgeInsets.only(
          top: size.height * 0.03,
          bottom: size.height * 0.06,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          'Please enter your email and we will send \nyou a link to return to your account',
          style: TextStyle(
            color: kTextColor.withOpacity(0.8),
          ),
        ),
      ),
      navigateCallback: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute(
            builder: (context) => const MainMenu(),
          ),
        );
      },
    );
  }
}
