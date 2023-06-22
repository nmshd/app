// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dvo_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DVOError _$DVOErrorFromJson(Map<String, dynamic> json) => DVOError(
      code: json['code'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DVOErrorToJson(DVOError instance) {
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
