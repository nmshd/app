// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backbone_compatibility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckBackboneCompatibilityResponse _$CheckBackboneCompatibilityResponseFromJson(Map<String, dynamic> json) => CheckBackboneCompatibilityResponse(
  isCompatible: json['isCompatible'] as bool,
  backboneVersion: const IntegerConverter().fromJson((json['backboneVersion'] as num).toInt()),
  supportedMinBackboneVersion: const IntegerConverter().fromJson((json['supportedMinBackboneVersion'] as num).toInt()),
  supportedMaxBackboneVersion: const IntegerConverter().fromJson((json['supportedMaxBackboneVersion'] as num).toInt()),
);

Map<String, dynamic> _$CheckBackboneCompatibilityResponseToJson(CheckBackboneCompatibilityResponse instance) => <String, dynamic>{
  'isCompatible': instance.isCompatible,
  'backboneVersion': const IntegerConverter().toJson(instance.backboneVersion),
  'supportedMinBackboneVersion': const IntegerConverter().toJson(instance.supportedMinBackboneVersion),
  'supportedMaxBackboneVersion': const IntegerConverter().toJson(instance.supportedMaxBackboneVersion),
};
