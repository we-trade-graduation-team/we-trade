import 'package:flutter/material.dart';

import 'top_rounded_container.dart';

class AuthCustomBackground extends StatelessWidget {
  const AuthCustomBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: TopRoundedContainer(
            color: Colors.grey[400],
            width: size.width - 20,
            topMargin: 40,
          ),
        ),
        TopRoundedContainer(
          color: Colors.white,
          topMargin: 50,
          child: child,
        ),
      ],
    );
  }
}
