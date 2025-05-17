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
);

Map<String, dynamic> _$AnnouncementDTOToJson(AnnouncementDTO instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt,
  if (instance.expiresAt case final value?) 'expiresAt': value,
  'severity': _$AnnouncementSeverityEnumMap[instance.severity]!,
  'title': instance.title,
  'body': instance.body,
};

const _$AnnouncementSeverityEnumMap = {AnnouncementSeverity.low: 'low', AnnouncementSeverity.medium: 'medium', AnnouncementSeverity.high: 'high'};
