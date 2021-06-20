import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class PostDetailsSeparator extends StatelessWidget {
  const PostDetailsSeparator({
    Key? key,
    required this.height,
    this.color = AppColors.kScreenBackgroundColor,
  }) : super(key: key);

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
    properties.add(ColorProperty('color', color));
  }
}
