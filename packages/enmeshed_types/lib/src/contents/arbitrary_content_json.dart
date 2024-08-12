mixin ArbitraryContentJSON {
  Map<String, dynamic> get value;

  String? get type => value['@type'];

  Map<String, dynamic> toJson() => value;

  dynamic operator [](Object? key) => value[key];

  void operator []=(String key, value) => value[key] = value;

  void clear() => value.clear();

  Iterable<String> get keys => value.keys;

  void remove(Object? key) => value.remove(key);
}
