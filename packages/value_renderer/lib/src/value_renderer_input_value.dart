sealed class ValueRendererInputValue {
  const ValueRendererInputValue();

  factory ValueRendererInputValue.fromJson(dynamic json) => switch (json) {
        String() => ValueRendererInputValueString(json),
        num() => ValueRendererInputValueNum(json),
        bool() => ValueRendererInputValueBool(json),
        Map() => ValueRendererInputValueMap(json),
        DateTime() => ValueRendererInputValueDateTime(json),
        _ => throw Exception('Invalid type for ValueRendererInputValue: ${json.runtimeType}'),
      };

  dynamic toJson();
}

class ValueRendererInputValueString implements ValueRendererInputValue {
  final String value;

  const ValueRendererInputValueString(this.value);

  @override
  String toJson() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || runtimeType == other.runtimeType && value == (other as ValueRendererInputValueString).value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class ValueRendererInputValueNum implements ValueRendererInputValue {
  final num value;

  const ValueRendererInputValueNum(this.value);

  @override
  num toJson() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || runtimeType == other.runtimeType && value == (other as ValueRendererInputValueNum).value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class ValueRendererInputValueBool implements ValueRendererInputValue {
  final bool value;

  const ValueRendererInputValueBool(this.value);

  @override
  bool toJson() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || runtimeType == other.runtimeType && value == (other as ValueRendererInputValueBool).value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class ValueRendererInputValueMap implements ValueRendererInputValue {
  final Map value;

  const ValueRendererInputValueMap(this.value);

  @override
  Map toJson() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || runtimeType == other.runtimeType && value == (other as ValueRendererInputValueMap).value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class ValueRendererInputValueDateTime implements ValueRendererInputValue {
  final DateTime value;

  const ValueRendererInputValueDateTime(this.value);

  @override
  DateTime toJson() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || runtimeType == other.runtimeType && value == (other as ValueRendererInputValueDateTime).value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
