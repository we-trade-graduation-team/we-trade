import 'package:flutter/material.dart';

import 'section_title_row_model.dart';

class SectionColumnModel {
  SectionColumnModel({
    required this.sectionTitleRowModel,
    required this.child,
  });

  final SectionTitleRowModel sectionTitleRowModel;
  final Widget child;
}
