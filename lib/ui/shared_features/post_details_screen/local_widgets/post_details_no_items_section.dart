import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_number_constants.dart';

import 'post_details_section_container.dart';

class PostDetailsNoItemsSection extends StatelessWidget {
  const PostDetailsNoItemsSection({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    
    return PostDetailsSectionContainer(
      child: Padding(
        padding: EdgeInsets.only(
          right: _size.width * AppNumberConstants.kDetailHorizontalPaddingPercent * 2,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.5)),
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
