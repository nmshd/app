// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_response_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalResponseSourceDTO _$LocalResponseSourceDTOFromJson(Map<String, dynamic> json) =>
    LocalResponseSourceDTO(type: $enumDecode(_$LocalResponseSourceTypeEnumMap, json['type']), reference: json['reference'] as String);

Map<String, dynamic> _$LocalResponseSourceDTOToJson(LocalResponseSourceDTO instance) => <String, dynamic>{
  'type': _$LocalResponseSourceTypeEnumMap[instance.type]!,
  'reference': instance.reference,
};

const _$LocalResponseSourceTypeEnumMap = {LocalResponseSourceType.Message: 'Message', LocalResponseSourceType.Relationship: 'Relationship'};
