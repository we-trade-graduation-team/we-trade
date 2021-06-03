import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../../../main_menu.dart';
import '../../shared_widgets/auth_custom_background.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String? phoneNumber;

  @override
  _BodyState createState() => _BodyState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('phoneNumber', phoneNumber));
  }
}

class _BodyState extends State<Body> {
  late TextEditingController _textEditingController;
  // ..text = "123456";

  // ignore: close_sinks
  late StreamController<ErrorAnimationType>? _errorController;

  late bool _hasError;
  late String _currentText;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _errorController = StreamController<ErrorAnimationType>();
    _hasError = false;
    _currentText = '';
  }

  @override
  void dispose() {
    _errorController!.close();

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
    return AuthCustomBackground(
      inputFormChildren: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Lottie.network(
            lottieUrl,
            // width: 150,
            height: 150,
            // fit: BoxFit.fill,
            // alignment: Alignment.center,
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
          key: _formKey,
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
                AppAssets.blackCircleIcon,
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
                inactiveColor: AppColors.kTextColor.withOpacity(0.5),
                selectedFillColor: Theme.of(context).primaryColorLight,
                selectedColor: Theme.of(context).primaryColor,
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor:
                    _hasError ? Colors.blue.shade100 : Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController: _errorController,
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // print(value);
                setState(() {
                  _currentText = value;
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
            _hasError ? '*Please fill up all the cells properly' : '',
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
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
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
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ButtonTheme(
            height: size.height * 0.06,
            child: TextButton(
              onPressed: () {
                _formKey.currentState!.validate();
                // conditions for validating
                if (_currentText.length != otpLength ||
                    _currentText != demoOTP) {
                  _errorController!.add(ErrorAnimationType
                      .shake); // Triggering error shake animation
                  setState(() {
                    _hasError = true;
                  });
                } else {
                  setState(
                    () {
                      _hasError = false;
                      // snackBar('OTP Verified!!');
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) => const MainMenu(),
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
                  _textEditingController.clear();
                },
                child: const Text('Clear'),
              ),
            ),
            Flexible(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _textEditingController.text = demoOTP;
                  });
                },
                child: const Text('Set Text'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
