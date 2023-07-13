import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'contents.dart';

part 'value_hints.g.dart';

@JsonSerializable(includeIfNull: false)
class ValueHints extends Equatable {
  final String? editHelp;
  final int? min;
  final int? max;
  final String? pattern;
  final List<ValueHintsValue>? values;
  final dynamic defaultValue;
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
