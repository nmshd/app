import 'package:equatable/equatable.dart';

import 'contents.dart';

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

  factory ValueHints.fromJson(Map<String, dynamic> json) {
    return ValueHints(
      editHelp: json['editHelp'],
      min: json['min']?.toInt(),
      max: json['max']?.toInt(),
      pattern: json['pattern'],
      values: json['values'] != null
          ? List<ValueHintsValue>.from(json['values'].map(
              (x) => ValueHintsValue.fromJson(x),
            ))
          : null,
      defaultValue: json['defaultValue'],
      propertyHints: json['propertyHints'] != null
          ? Map<String, ValueHints>.from(json['propertyHints'].map(
              (key, value) => MapEntry(
                key,
                ValueHints.fromJson(value),
              ),
            ))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'editHelp': editHelp,
        'min': min,
        'max': max,
        'pattern': pattern,
        'values': values?.map((x) => x.toJson()).toList(),
        'defaultValue': defaultValue,
        'propertyHints': propertyHints?.map((key, value) => MapEntry(
              key,
              value.toJson(),
            )),
      };

  @override
  String toString() {
    return 'ValueHints(editHelp: $editHelp, min: $min, max: $max, pattern: $pattern, values: $values, defaultValue: $defaultValue, propertyHints: $propertyHints)';
  }

  @override
  List<Object?> get props => [editHelp, min, max, pattern, values, defaultValue, propertyHints];
}
