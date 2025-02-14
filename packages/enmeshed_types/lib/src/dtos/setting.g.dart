// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingDTO _$SettingDTOFromJson(Map<String, dynamic> json) => SettingDTO(
  id: json['id'] as String,
  key: json['key'] as String,
  scope: $enumDecode(_$SettingScopeEnumMap, json['scope']),
  value: json['value'] as Map<String, dynamic>,
  createdAt: json['createdAt'] as String,
  reference: json['reference'] as String?,
  succeedsItem: json['succeedsItem'] as String?,
  succeedsAt: json['succeedsAt'] as String?,
);

Map<String, dynamic> _$SettingDTOToJson(SettingDTO instance) => <String, dynamic>{
  'id': instance.id,
  'key': instance.key,
  'scope': _$SettingScopeEnumMap[instance.scope]!,
  'value': instance.value,
  'createdAt': instance.createdAt,
  if (instance.reference case final value?) 'reference': value,
  if (instance.succeedsItem case final value?) 'succeedsItem': value,
  if (instance.succeedsAt case final value?) 'succeedsAt': value,
};

const _$SettingScopeEnumMap = {SettingScope.Identity: 'Identity', SettingScope.Device: 'Device', SettingScope.Relationship: 'Relationship'};
