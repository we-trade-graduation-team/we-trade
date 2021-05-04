import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'home_section_column.dart';

class HomeSectionWithListViewChild extends StatelessWidget {
  const HomeSectionWithListViewChild({
    Key? key,
    required this.title,
    required this.child,
    required this.press,
  }) : super(key: key);

  final String title;
  final Widget child;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return HomeSectionColumn(
      title: title,
      press: press,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.05),
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(StringProperty('title', title));
  }
}
