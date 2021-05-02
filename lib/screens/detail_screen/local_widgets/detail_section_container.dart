import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/keys.dart';

class DetailSectionContainer extends StatelessWidget {
  const DetailSectionContainer({
    Key? key,
    required this.child,
    this.height,
  }) : super(key: key);

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.white,
      height: height,
      padding: EdgeInsets.only(
        left: size.width * kDetailHorizontalPaddingPercent,
        top: size.height * kDetailVerticalPaddingPercent,
        bottom: size.height * kDetailVerticalPaddingPercent,
      ),
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
  }
}
