// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backbone_compatibility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckBackboneCompatibilityResponse _$CheckBackboneCompatibilityResponseFromJson(Map<String, dynamic> json) => CheckBackboneCompatibilityResponse(
      isCompatible: json['isCompatible'] as bool,
      backboneVersion: json['backboneVersion'],
      supportedMinBackboneVersion: json['supportedMinBackboneVersion'],
      supportedMaxBackboneVersion: json['supportedMaxBackboneVersion'],
    );

Map<String, dynamic> _$CheckBackboneCompatibilityResponseToJson(CheckBackboneCompatibilityResponse instance) {
  final val = <String, dynamic>{
    'isCompatible': instance.isCompatible,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('backboneVersion', instance.backboneVersion);
  writeNotNull('supportedMinBackboneVersion', instance.supportedMinBackboneVersion);
  writeNotNull('supportedMaxBackboneVersion', instance.supportedMaxBackboneVersion);
  return val;
}
