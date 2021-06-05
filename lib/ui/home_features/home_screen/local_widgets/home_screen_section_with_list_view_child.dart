import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/ui/home_features/home_screen/section_column_model.dart';

import 'home_screen_section_column.dart';

class HomeScreenSectionWithListViewChild extends StatelessWidget {
  const HomeScreenSectionWithListViewChild({
    Key? key,
    required this.sectionColumnModel,
  }) : super(key: key);

  final SectionColumnModel sectionColumnModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return HomeScreenSectionColumn(
      sectionColumnModel: SectionColumnModel(
        sectionTitleRowModel: sectionColumnModel.sectionTitleRowModel,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.05,
          ),
          child: sectionColumnModel.child,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SectionColumnModel>(
        'sectionColumnModel', sectionColumnModel));
  }
}
