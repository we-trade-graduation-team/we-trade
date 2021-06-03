import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'local_widgets/body.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Body(phoneNumber: phoneNumber),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('phoneNumber', phoneNumber));
  }
}
