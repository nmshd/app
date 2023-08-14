// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_hints_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueHintsValue _$ValueHintsValueFromJson(Map<String, dynamic> json) => ValueHintsValue(
      key: ValueHintsDefaultValue.fromJson(json['key']),
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$ValueHintsValueToJson(ValueHintsValue instance) => <String, dynamic>{
      'key': instance.key.toJson(),
      'displayName': instance.displayName,
    };
