class PostCardProperties {
  PostCardProperties._();

  static dynamic getProp(String key) {
    final _properties = <String, dynamic>{
      'postId': 'postId',
      'title': 'title',
      'view': 'view',
    };

    final _defaultProp = _properties['view'] as String;

    return _properties[key] ?? _defaultProp;
  }
}
