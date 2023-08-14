// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_hints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueHints _$ValueHintsFromJson(Map<String, dynamic> json) => ValueHints(
      editHelp: json['editHelp'] as String?,
      min: json['min'] as int?,
      max: json['max'] as int?,
      pattern: json['pattern'] as String?,
      values: (json['values'] as List<dynamic>?)?.map((e) => ValueHintsValue.fromJson(e as Map<String, dynamic>)).toList(),
      defaultValue: json['defaultValue'],
      propertyHints: (json['propertyHints'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ValueHints.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ValueHintsToJson(ValueHints instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('editHelp', instance.editHelp);
  writeNotNull('min', instance.min);
  writeNotNull('max', instance.max);
  writeNotNull('pattern', instance.pattern);
  writeNotNull('values', instance.values?.map((e) => e.toJson()).toList());
  writeNotNull('defaultValue', instance.defaultValue);
  writeNotNull('propertyHints', instance.propertyHints?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}
