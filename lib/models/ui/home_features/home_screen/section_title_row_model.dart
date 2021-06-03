import 'package:flutter/material.dart';

class SectionTitleRowModel {
  SectionTitleRowModel({
    required this.title,
    required this.press,
    this.seeMore = true,
  });

  final String title;
  final VoidCallback press;
  final bool seeMore;
}
