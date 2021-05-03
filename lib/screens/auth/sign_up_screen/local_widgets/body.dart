import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/keys.dart';
import '../../../../widgets/auth/auth_custom_background.dart';
import '../../../../widgets/auth/custom_form_builder_text_field.dart';
import '../../../../widgets/auth/rounded_icon_button.dart';
import '../../complete_profile_screen/complete_profile_screen.dart';
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
  late FocusScopeNode node;

  // final ValueChanged _onChanged = print;

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
                      'Sign up and\nstarting trading',
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
                          name: 'email',
                          labelText: 'Email',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context),
                          ]),
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        CustomFormBuilderTextField(
                          name: 'password',
                          labelText: 'Password',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 6),
                          ]),
                          obscureText: true,
                          onEditingComplete: () => node.nextFocus(),
                        ),
                        const SizedBox(height: 10),
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
                              if (val !=
                                  _formKey.currentState?.fields['password']
                                      ?.value) {
                                return 'Passwords do not match';
                              }
                              return null;
                            }
                          ]),
                          obscureText: true,
                          onEditingComplete: () => node.unfocus(),
                        ),
                        const SizedBox(height: 20),
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
                            errorText:
                                'You must accept terms and conditions to continue',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 60,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign up',
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
                                    Navigator.pushNamed(context,
                                        CompleteProfileScreen.routeName);
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
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
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
  }
}
