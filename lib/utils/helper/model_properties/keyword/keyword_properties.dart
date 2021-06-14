class KeywordProperties {
  KeywordProperties._();

  static dynamic getProp(String key) {
    final _properties = <String, dynamic>{
      'keywordId': 'keywordId',
      'keyword': 'keyword',
    };

    final _defaultProp = _properties['keywordId'] as String;

    return _properties[key] ?? _defaultProp;
  }
}
