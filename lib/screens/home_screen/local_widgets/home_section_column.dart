import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'section_title_row.dart';

class HomeSectionColumn extends StatelessWidget {
  const HomeSectionColumn({
    Key? key,
    required this.title,
    required this.child,
    required this.press,
    this.seeMore = true,
  }) : super(key: key);

  final String title;
  final Widget child;
  final GestureTapCallback press;
  final bool seeMore;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleRow(
          title: title,
          press: press,
          seeMore: seeMore,
        ),
        SizedBox(height: size.height * 0.025),
        child,
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has('press', press));
    properties.add(DiagnosticsProperty<bool>('seeMore', seeMore));
  }
}
