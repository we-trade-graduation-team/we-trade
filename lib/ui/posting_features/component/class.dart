class TypeOfGoods {
  TypeOfGoods({required this.id, required this.name, this.selected = false});
  final String id;
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

class KeyWord {
  KeyWord({
    required this.id,
    required this.value,
  });

  final String id;
  final String value;
}
