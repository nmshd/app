// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dvo_warning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DVOWarning _$DVOWarningFromJson(Map<String, dynamic> json) => DVOWarning(
      code: json['code'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DVOWarningToJson(DVOWarning instance) {
  final val = <String, dynamic>{
    'code': instance.code,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  return val;
}
