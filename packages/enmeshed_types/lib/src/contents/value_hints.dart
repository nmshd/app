import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../dvos/integer_converter.dart';
import 'contents.dart';

part 'value_hints.g.dart';

@JsonSerializable(includeIfNull: false)
class ValueHints extends Equatable {
  final String? editHelp;
  @OptionalIntegerConverter()
  final int? min;
  @OptionalIntegerConverter()
  final int? max;
  final String? pattern;
  final List<ValueHintsValue>? values;

  final ValueHintsDefaultValue? defaultValue;
  final Map<String, ValueHints>? propertyHints;

  const ValueHints({
    this.editHelp,
    this.min,
    this.max,
    this.pattern,
    this.values,
    this.defaultValue,
    this.propertyHints,
  });

  factory ValueHints.fromJson(Map json) => _$ValueHintsFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => {'@type': 'ValueHints', ..._$ValueHintsToJson(this)};

  @override
  String toString() {
    return 'ValueHints(editHelp: $editHelp, min: $min, max: $max, pattern: $pattern, values: $values, defaultValue: $defaultValue, propertyHints: $propertyHints)';
  }

  @override
  List<Object?> get props => [editHelp, min, max, pattern, values, defaultValue, propertyHints];
}

sealed class ValueHintsDefaultValue {
  const ValueHintsDefaultValue();

  factory ValueHintsDefaultValue.fromJson(dynamic json) => switch (json) {
        String() => ValueHintsDefaultValueString(json),
        num() => ValueHintsDefaultValueNum(json),
        bool() => ValueHintsDefaultValueBool(json),
        _ => throw Exception('Invalid type for ValueHintsDefaultValue: ${json.runtimeType}'),
      };

  dynamic toJson();
}

class ValueHintsDefaultValueString implements ValueHintsDefaultValue {
  final String value;

  const ValueHintsDefaultValueString(this.value);

  @override
  String toJson() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || runtimeType == other.runtimeType && value == (other as ValueHintsDefaultValueString).value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class ValueHintsDefaultValueNum implements ValueHintsDefaultValue {
  final num value;

  const ValueHintsDefaultValueNum(this.value);

  @override
  num toJson() => value;

  @override
  bool operator ==(Object other) => identical(this, other) || runtimeType == other.runtimeType && value == (other as ValueHintsDefaultValueNum).value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

class ValueHintsDefaultValueBool implements ValueHintsDefaultValue {
  final bool value;

  const ValueHintsDefaultValueBool(this.value);

  @override
  bool toJson() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || runtimeType == other.runtimeType && value == (other as ValueHintsDefaultValueBool).value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}

extension Translation on ValueHints {
  String getTranslation(
    dynamic value,
  ) {
    if (values == null) return value;
    final valueHint = values!.firstWhereOrNull((valueHint) => valueHint.key.toJson() == value);

    if (valueHint == null) return value;
    return valueHint.displayName;
  }
}
