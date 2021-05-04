import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/keys.dart';
import '../../otp_screen/otp_screen.dart';
import '../../shared_widgets/auth_custom_background.dart';
import '../../shared_widgets/custom_form_builder_text_field.dart';
import '../../shared_widgets/rounded_icon_button.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormBuilderState>();
  late FocusScopeNode node;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    node = FocusScope.of(context);
    return GestureDetector(
      onTap: () => node.unfocus(),
      child: AuthCustomBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: AnimationLimiter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(
                    milliseconds: kFlutterStaggeredAnimationsDuration),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Complete\nprofile',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: kTextColor.withOpacity(0.9),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.06),
                  FormBuilder(
                    key: _formKey,
                    onChanged: () {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomFormBuilderTextField(
                          name: 'first_name',
                          labelText: 'First name',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 10),
                        CustomFormBuilderTextField(
                          name: 'last_name',
                          labelText: 'Last name',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 10),
                        CustomFormBuilderTextField(
                          name: 'phone_number',
                          labelText: 'Phone number',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 10),
                          ]),
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        CustomFormBuilderTextField(
                          name: 'address',
                          labelText: 'Address',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          onEditingComplete: () => node.unfocus(),
                          keyboardType: TextInputType.streetAddress,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 60,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Complete profile',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor.withOpacity(0.8),
                                  )),
                              RoundedIconButton(
                                icon: const Icon(
                                  LineIcons.angleRight,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                fillColor: kPrimaryColor,
                                width: 60,
                                onPressed: () {
                                  node.unfocus();

                                  if (_formKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    Navigator.pushNamed(
                                        context, OtpScreen.routeName);
                                  }
                                },
                                elevation: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<GlobalKey<FormBuilderState>>('_formKey', _formKey));
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
  }
}
