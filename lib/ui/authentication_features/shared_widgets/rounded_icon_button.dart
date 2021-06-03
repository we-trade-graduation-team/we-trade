import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.width,
    this.elevation = 0,
    this.fillColor = Colors.white,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onPressed;
  final double elevation;
  final double? width;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints.expand(
        height: width,
        width: width,
      ),
      fillColor: fillColor,
      shape: const CircleBorder(),
      child: icon,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(ColorProperty('fillColor', fillColor));
    properties.add(DoubleProperty('width', width));
  }
}
