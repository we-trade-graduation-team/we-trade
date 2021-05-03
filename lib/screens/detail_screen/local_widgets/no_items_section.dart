import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';
import '../../../configs/constants/keys.dart';

import 'detail_section_container.dart';

class NoItemsSection extends StatelessWidget {
  const NoItemsSection({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DetailSectionContainer(
      child: Padding(
        padding: EdgeInsets.only(
          right: size.width * kDetailHorizontalPaddingPercent * 2,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }
}
