class SpecialCategoryCardProperties {
  SpecialCategoryCardProperties._();

  static dynamic getProp(String key) {
    final _properties = <String, dynamic>{
      'categoryId': 'categoryId',
      'category': 'category',
      'photoUrl': 'photoUrl',
      'view': 'view',
    };

    final _defaultProp = _properties['view'] as String;

    return _properties[key] ?? _defaultProp;
  }
}
