// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backbone_compatibility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckBackboneCompatibilityResponse _$CheckBackboneCompatibilityResponseFromJson(Map<String, dynamic> json) => CheckBackboneCompatibilityResponse(
      isCompatible: json['isCompatible'] as bool,
      backboneVersion: const IntegerConverter().fromJson(json['backboneVersion']),
      supportedMinBackboneVersion: const IntegerConverter().fromJson(json['supportedMinBackboneVersion']),
      supportedMaxBackboneVersion: const IntegerConverter().fromJson(json['supportedMaxBackboneVersion']),
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

  writeNotNull('backboneVersion', const IntegerConverter().toJson(instance.backboneVersion));
  writeNotNull('supportedMinBackboneVersion', const IntegerConverter().toJson(instance.supportedMinBackboneVersion));
  writeNotNull('supportedMaxBackboneVersion', const IntegerConverter().toJson(instance.supportedMaxBackboneVersion));
  return val;
}
