import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/keys.dart';
import '../../../../main_menu.dart';
import '../../../../widgets/auth/auth_custom_background.dart';
import '../../../../widgets/auth/custom_form_builder_text_field.dart';
import '../../../../widgets/auth/rounded_icon_button.dart';

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
                      'Forgot\npassword',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: kTextColor.withOpacity(0.9),
                      ),
                    ),
                  ),
                  // SizedBox(height: size.height * 0.03),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.03, bottom: size.height * 0.06),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Please enter your email and we will send \nyou a link to return to your account',
                      style: TextStyle(
                        color: kTextColor.withOpacity(0.8),
                      ),
                    ),
                  ),
                  // SizedBox(height: size.height * 0.06),
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
                        SizedBox(height: size.height * 0.06),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Forgot password',
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
