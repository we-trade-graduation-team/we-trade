import 'package:freezed_annotation/freezed_annotation.dart';

class TypeofGoods {
  TypeofGoods({required this.id, required this.name, this.selected = false});
  final int id;
  bool selected;
  final String name;
}

class Conditions {
  Conditions({required this.priority, required this.description});
  final int priority;
  final String description;
}

class Cities {
  Cities({required this.id, required this.name, this.selected = false});
  final String id;
  bool selected;
  final String name;
}
