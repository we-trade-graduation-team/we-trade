import 'package:flutter/material.dart';

class DetailSection {
  DetailSection({
    this.titleSection,
    required this.children,
  });

  final String? titleSection;
  final List<Widget> children;
}
