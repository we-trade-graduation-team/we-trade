import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../configs/constants/assets_path.dart';
import '../../../configs/constants/color.dart';
import '../../../configs/constants/keys.dart';
import '../../../main_menu.dart';
import '../../../widgets/auth/auth_custom_background.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  static String routeName = '/otp';
  final String? phoneNumber;

  @override
  _OtpScreenState createState() => _OtpScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('phoneNumber', phoneNumber));
  }
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController textEditingController;
  // ..text = "123456";

  // ignore: close_sinks
  late StreamController<ErrorAnimationType>? errorController;

  late bool hasError;
  late String currentText;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    textEditingController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
    hasError = false;
    currentText = '';

    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // snackBar Widget
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    const lottieUrl =
        'https://assets9.lottiefiles.com/private_files/lf30_gva1sgii.json';
    const demoOTP = '1234';
    const otpLength = 4;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {},
        child: AuthCustomBackground(
          child: LayoutBuilder(
            builder: (_, constraints) => ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Lottie.network(
                              lottieUrl,
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Phone Number Verification',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 8,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'Enter the code sent to ',
                                children: [
                                  TextSpan(
                                    text: widget.phoneNumber,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 30,
                              ),
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: otpLength,
                                obscureText: true,
                                obscuringCharacter: '*',
                                obscuringWidget: SvgPicture.asset(
                                  blackCircleIcon,
                                  height: 15,
                                  width: 15,
                                ),
                                // obscuringWidget: const FlutterLogo(size: 24),
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v!.length < 3) {
                                    return 'Fill all!';
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  inactiveFillColor: Colors.white,
                                  inactiveColor: kTextColor.withOpacity(0.5),
                                  selectedFillColor: kPrimaryLightColor,
                                  selectedColor: kPrimaryColor,
                                  fieldHeight: 50,
                                  fieldWidth: 50,
                                  activeFillColor: hasError
                                      ? Colors.blue.shade100
                                      : Colors.white,
                                ),
                                cursorColor: Colors.black,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                errorAnimationController: errorController,
                                controller: textEditingController,
                                keyboardType: TextInputType.number,
                                // boxShadows: const [
                                //   BoxShadow(
                                //     offset: Offset(0, 1),
                                //     color: Colors.black12,
                                //     blurRadius: 10,
                                //   ),
                                // ],
                                // onCompleted: (v) {
                                //   print('Completed');
                                // },
                                // onTap: () {
                                //   print("Pressed");
                                // },
                                onChanged: (value) {
                                  // print(value);
                                  setState(() {
                                    currentText = value;
                                  });
                                },
                                beforeTextPaste: (text) {
                                  // print('Allowing to paste $text');
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              hasError
                                  ? '*Please fill up all the cells properly'
                                  : '',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn't receive the code? ",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => snackBar('OTP resend!!'),
                                child: Text(
                                  'resend'.toUpperCase(),
                                  style: TextStyle(
                                    color: kPrimaryColor.withOpacity(0.6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(5),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.green.shade200,
                              //     offset: const Offset(1, -2),
                              //     blurRadius: 5,
                              //   ),
                              //   BoxShadow(
                              //     color: Colors.green.shade200,
                              //     offset: const Offset(-1, 2),
                              //     blurRadius: 5,
                              //   ),
                              // ],
                            ),
                            child: ButtonTheme(
                              height: size.height * 0.06,
                              child: TextButton(
                                onPressed: () {
                                  formKey.currentState!.validate();
                                  // conditions for validating
                                  if (currentText.length != otpLength ||
                                      currentText != demoOTP) {
                                    errorController!.add(ErrorAnimationType
                                        .shake); // Triggering error shake animation
                                    setState(() {
                                      hasError = true;
                                    });
                                  } else {
                                    setState(
                                      () {
                                        hasError = false;
                                        // snackBar('OTP Verified!!');
                                        Navigator.of(context).push<void>(
                                          MaterialPageRoute(
                                            builder: (context) => MainMenu(
                                                menuScreenContext: context),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'verify'.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: TextButton(
                                  onPressed: () {
                                    textEditingController.clear();
                                  },
                                  child: const Text(
                                    'Clear',
                                    style: TextStyle(color: kTextColor),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      textEditingController.text = demoOTP;
                                    });
                                  },
                                  child: const Text(
                                    'Set Text',
                                    style: TextStyle(color: kTextColor),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'textEditingController', textEditingController));
    properties.add(DiagnosticsProperty<StreamController<ErrorAnimationType>?>(
        'errorController', errorController));
    properties.add(StringProperty('currentText', currentText));
    properties.add(DiagnosticsProperty<bool>('hasError', hasError));
    properties
        .add(DiagnosticsProperty<GlobalKey<FormState>>('formKey', formKey));
  }
}
