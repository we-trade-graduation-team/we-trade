import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';

import 'home_screen_section_title_row.dart';

class HomeScreenSectionColumn extends StatelessWidget {
  const HomeScreenSectionColumn({
    Key? key,
    required this.sectionColumnModel,
  }) : super(key: key);

  final SectionColumnModel sectionColumnModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeScreenSectionTitleRow(
          sectionTitleRowModel: sectionColumnModel.sectionTitleRowModel,
        ),
        SizedBox(height: size.height * 0.025),
        sectionColumnModel.child,
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SectionColumnModel>(
        'sectionColumnModel', sectionColumnModel));
  }
}
