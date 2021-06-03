import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomAnimationLimiterForColumn extends StatelessWidget {
  const CustomAnimationLimiterForColumn({
    Key? key,
    required this.children,
    required this.duration,
    this.horizontalOffset = 50,
  }) : super(key: key);

  final List<Widget> children;
  final double? horizontalOffset;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: AnimationConfiguration.toStaggeredList(
          duration: duration,
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: horizontalOffset,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: children,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('horizontalOffset', horizontalOffset));
    properties.add(DiagnosticsProperty<Duration?>('duration', duration));
  }
}
