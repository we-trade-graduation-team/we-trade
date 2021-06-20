import 'package:flutter/material.dart';

class PostDetailsSection {
  PostDetailsSection({
    required this.children,
    this.titleSection,
  });

  final String? titleSection;
  final List<Widget> children;
}
