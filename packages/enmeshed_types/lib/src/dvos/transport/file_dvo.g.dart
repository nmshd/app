// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileDVO _$FileDVOFromJson(Map<String, dynamic> json) => FileDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  filename: json['filename'] as String,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  filesize: const IntegerConverter().fromJson(json['filesize'] as Object),
  createdAt: json['createdAt'] as String,
  createdBy: IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
  createdByDevice: json['createdByDevice'] as String,
  expiresAt: json['expiresAt'] as String,
  mimetype: json['mimetype'] as String,
  isOwn: json['isOwn'] as bool,
  title: json['title'] as String,
  reference: ObjectReferenceDTO.fromJson(json['reference'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FileDVOToJson(FileDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'filename': instance.filename,
  'tags': ?instance.tags,
  'filesize': const IntegerConverter().toJson(instance.filesize),
  'createdAt': instance.createdAt,
  'createdBy': instance.createdBy.toJson(),
  'createdByDevice': instance.createdByDevice,
  'expiresAt': instance.expiresAt,
  'mimetype': instance.mimetype,
  'isOwn': instance.isOwn,
  'title': instance.title,
  'reference': instance.reference.toJson(),
};
