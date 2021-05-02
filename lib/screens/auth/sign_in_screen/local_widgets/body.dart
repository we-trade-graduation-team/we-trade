import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../configs/constants/assets_path.dart';
import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/keys.dart';
import '../../../../main_menu.dart';
import '../../../../widgets/auth/auth_custom_background.dart';
import '../../../../widgets/auth/custom_form_builder_text_field.dart';
import '../../../../widgets/auth/rounded_icon_button.dart';
import '../../forgot_password_screen/forgot_password_screen.dart';
import '../../sign_up_screen/sign_up.dart';

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
    final socialIcons = [
      googleIcon,
      appleIcon,
      facebookIcon,
    ];
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
                      'Welcome\nBack',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: kTextColor.withOpacity(0.9),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  FormBuilder(
                    key: _formKey,
                    onChanged: () {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomFormBuilderTextField(
                          name: 'email',
                          labelText: 'Email address',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context),
                          ]),
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        CustomFormBuilderTextField(
                          name: 'password',
                          labelText: 'Password',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 6),
                          ]),
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => node.unfocus(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign in',
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
                                    Navigator.of(context).push<void>(
                                      MaterialPageRoute(
                                        builder: (context) => MainMenu(
                                            menuScreenContext: context),
                                      ),
                                    );
                                  }
                                },
                                elevation: 4,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 50,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: socialIcons
                                .map(
                                  (icon) => RoundedIconButton(
                                    icon: SvgPicture.asset(
                                      icon,
                                      height: 25,
                                      width: 25,
                                      placeholderBuilder: (context) =>
                                          Container(
                                        padding: const EdgeInsets.all(30),
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    ),
                                    elevation: 2,
                                    width: 50,
                                    onPressed: () {},
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                SignUpScreen.routeName,
                              ),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                ForgotPasswordScreen.routeName,
                              ),
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  // fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
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
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
  }
}
