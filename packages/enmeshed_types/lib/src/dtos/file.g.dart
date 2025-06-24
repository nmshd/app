// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileDTO _$FileDTOFromJson(Map<String, dynamic> json) => FileDTO(
  id: json['id'] as String,
  filename: json['filename'] as String,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  filesize: (json['filesize'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  createdBy: json['createdBy'] as String,
  createdByDevice: json['createdByDevice'] as String,
  expiresAt: json['expiresAt'] as String,
  mimetype: json['mimetype'] as String,
  isOwn: json['isOwn'] as bool,
  title: json['title'] as String,
  description: json['description'] as String?,
  reference: ObjectReferenceDTO.fromJson(json['reference'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FileDTOToJson(FileDTO instance) => <String, dynamic>{
  'id': instance.id,
  'filename': instance.filename,
  if (instance.tags case final value?) 'tags': value,
  'filesize': instance.filesize,
  'createdAt': instance.createdAt,
  'createdBy': instance.createdBy,
  'createdByDevice': instance.createdByDevice,
  'expiresAt': instance.expiresAt,
  'mimetype': instance.mimetype,
  'isOwn': instance.isOwn,
  'title': instance.title,
  if (instance.description case final value?) 'description': value,
  'reference': instance.reference.toJson(),
};
