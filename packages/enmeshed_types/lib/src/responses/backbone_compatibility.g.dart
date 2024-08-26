// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backbone_compatibility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckBackboneCompatibilityResponse _$CheckBackboneCompatibilityResponseFromJson(Map<String, dynamic> json) => CheckBackboneCompatibilityResponse(
      isCompatible: json['isCompatible'] as bool,
      backboneVersion: (json['backboneVersion'] as num).toInt(),
      supportedMinBackboneVersion: (json['supportedMinBackboneVersion'] as num).toInt(),
      supportedMaxBackboneVersion: (json['supportedMaxBackboneVersion'] as num).toInt(),
    );

Map<String, dynamic> _$CheckBackboneCompatibilityResponseToJson(CheckBackboneCompatibilityResponse instance) => <String, dynamic>{
      'isCompatible': instance.isCompatible,
      'backboneVersion': instance.backboneVersion,
      'supportedMinBackboneVersion': instance.supportedMinBackboneVersion,
      'supportedMaxBackboneVersion': instance.supportedMaxBackboneVersion,
    };
