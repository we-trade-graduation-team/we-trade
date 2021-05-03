import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SpecialEventBanner extends StatelessWidget {
  const SpecialEventBanner({
    Key? key,
    required this.backgroundColor,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const appBarDefaultHeight = 56;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        size.width * 0.065,
        size.height * 0.03 + appBarDefaultHeight + 20,
        size.width * 0.065,
        size.height * 0.03,
      ),
      // padding: const EdgeInsets.only(top: appBarDefaultHeight + 20),
      decoration: BoxDecoration(color: backgroundColor),
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor));
  }
}
