import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({
    Key? key,
    required this.verticalPadding,
    required this.horizontalPadding,
  }) : super(key: key);
  final double verticalPadding;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: const Center(
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
          ),
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('verticalPadding', verticalPadding));
    properties.add(DoubleProperty('horizontalPadding', horizontalPadding));
  }
}

class DataDoesNotExist extends StatelessWidget {
  const DataDoesNotExist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Document does not exist',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.red.withOpacity(0.6),
        ));
  }
}

class WentWrong extends StatelessWidget {
  const WentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Something went wrong',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.red.withOpacity(0.6),
        ));
  }
}

class CenterNotificationWhenHaveNoRecord extends StatelessWidget {
  const CenterNotificationWhenHaveNoRecord({Key? key, required this.text})
      : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }
}
