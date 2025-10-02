// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_hints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueHints _$ValueHintsFromJson(Map<String, dynamic> json) => ValueHints(
  editHelp: json['editHelp'] as String?,
  min: const OptionalIntegerConverter().fromJson(json['min']),
  max: const OptionalIntegerConverter().fromJson(json['max']),
  pattern: json['pattern'] as String?,
  values: (json['values'] as List<dynamic>?)
      ?.map((e) => ValueHintsValue.fromJson(e as Map<String, dynamic>))
      .toList(),
  defaultValue: json['defaultValue'] == null
      ? null
      : ValueHintsDefaultValue.fromJson(json['defaultValue']),
  propertyHints: (json['propertyHints'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, ValueHints.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$ValueHintsToJson(ValueHints instance) =>
    <String, dynamic>{
      'editHelp': ?instance.editHelp,
      'min': ?const OptionalIntegerConverter().toJson(instance.min),
      'max': ?const OptionalIntegerConverter().toJson(instance.max),
      'pattern': ?instance.pattern,
      'values': ?instance.values?.map((e) => e.toJson()).toList(),
      'defaultValue': ?instance.defaultValue?.toJson(),
      'propertyHints': ?instance.propertyHints?.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
    };
