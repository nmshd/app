extension Query on Map<String, QueryValue> {
  Map<String, dynamic> toJson() => map((key, value) => MapEntry(key, value.toJson()));
}

extension QueryValueFromEnum on Enum {
  QueryValue get asQueryValue => QueryValue.string(name);
}

abstract class QueryValue {
  dynamic toJson();

  QueryValue();

  factory QueryValue.string(String value) => _QueryValueString(value);
  factory QueryValue.stringList(List<String> value) => _QueryValueStringList(value);
}

class _QueryValueString extends QueryValue {
  final String value;
  _QueryValueString(this.value);

  @override
  dynamic toJson() => value;
}

class _QueryValueStringList extends QueryValue {
  final List<String> value;
  _QueryValueStringList(this.value);

  @override
  dynamic toJson() => value;
}
