// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_hints_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueHintsValue _$ValueHintsValueFromJson(Map<String, dynamic> json) => ValueHintsValue(
      key: json['key'],
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$ValueHintsValueToJson(ValueHintsValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  val['displayName'] = instance.displayName;
  return val;
}
