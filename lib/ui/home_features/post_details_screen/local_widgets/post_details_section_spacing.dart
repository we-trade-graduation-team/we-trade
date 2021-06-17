import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SectionSpacing extends StatelessWidget {
  const SectionSpacing({
    Key? key,
    required this.percent,
  }) : super(key: key);

  final double percent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * percent);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('percent', percent));
  }
}

class BigSectionSpacing extends SectionSpacing {
  const BigSectionSpacing({
    Key? key,
    double percent = bigSpacingPercent,
  }) : super(key: key, percent: percent);
}

class SmallSectionSpacing extends SectionSpacing {
  const SmallSectionSpacing({
    Key? key,
    double percent = bigSpacingPercent / 5,
  }) : super(key: key, percent: percent);
}

const bigSpacingPercent = 0.02;
