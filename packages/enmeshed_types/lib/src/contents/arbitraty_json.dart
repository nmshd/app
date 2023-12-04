mixin ArbitraryJSON {
  Map<String, dynamic> get internalJson;

  String? get type => internalJson['@type'];

  Map<String, dynamic> toJson() => internalJson;

  dynamic operator [](Object? key) => internalJson[key];

  void operator []=(String key, value) => internalJson[key] = value;

  void clear() => internalJson.clear();

  Iterable<String> get keys => internalJson.keys;

  void remove(Object? key) => internalJson.remove(key);
}
