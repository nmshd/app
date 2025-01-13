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

Map<String, dynamic> _$CheckBackboneCompatibilityResponseToJson(CheckBackboneCompatibilityResponse instance) => <String, dynamic>{
      'isCompatible': instance.isCompatible,
      if (const IntegerConverter().toJson(instance.backboneVersion) case final value?) 'backboneVersion': value,
      if (const IntegerConverter().toJson(instance.supportedMinBackboneVersion) case final value?) 'supportedMinBackboneVersion': value,
      if (const IntegerConverter().toJson(instance.supportedMaxBackboneVersion) case final value?) 'supportedMaxBackboneVersion': value,
    };
