import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_dimens.dart';

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
        left: size.width * AppDimens.kDetailHorizontalPaddingPercent,
        top: size.height * AppDimens.kDetailVerticalPaddingPercent,
        bottom: size.height * AppDimens.kDetailVerticalPaddingPercent,
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
