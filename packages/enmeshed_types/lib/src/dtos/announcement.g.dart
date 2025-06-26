// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementDTO _$AnnouncementDTOFromJson(Map<String, dynamic> json) => AnnouncementDTO(
  id: json['id'] as String,
  createdAt: json['createdAt'] as String,
  expiresAt: json['expiresAt'] as String?,
  severity: $enumDecode(_$AnnouncementSeverityEnumMap, json['severity']),
  title: json['title'] as String,
  body: json['body'] as String,
  actions: (json['actions'] as List<dynamic>).map((e) => AnnouncementActionDTO.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$AnnouncementDTOToJson(AnnouncementDTO instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt,
  if (instance.expiresAt case final value?) 'expiresAt': value,
  'severity': _$AnnouncementSeverityEnumMap[instance.severity]!,
  'title': instance.title,
  'body': instance.body,
  'actions': instance.actions.map((e) => e.toJson()).toList(),
};

const _$AnnouncementSeverityEnumMap = {AnnouncementSeverity.low: 'low', AnnouncementSeverity.medium: 'medium', AnnouncementSeverity.high: 'high'};

AnnouncementActionDTO _$AnnouncementActionDTOFromJson(Map<String, dynamic> json) =>
    AnnouncementActionDTO(displayName: json['displayName'] as String, link: json['link'] as String);

Map<String, dynamic> _$AnnouncementActionDTOToJson(AnnouncementActionDTO instance) => <String, dynamic>{
  'displayName': instance.displayName,
  'link': instance.link,
};
