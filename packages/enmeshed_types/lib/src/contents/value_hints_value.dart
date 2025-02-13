import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'value_hints.dart';

part 'value_hints_value.g.dart';

@JsonSerializable(includeIfNull: false)
class ValueHintsValue extends Equatable {
  final ValueHintsDefaultValue key;
  final String displayName;

  const ValueHintsValue({required this.key, required this.displayName});

  factory ValueHintsValue.fromJson(Map json) => _$ValueHintsValueFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => {'@type': 'ValueHintsValue', ..._$ValueHintsValueToJson(this)};

  @override
  List<Object?> get props => [key, displayName];
}
