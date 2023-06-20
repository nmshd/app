// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileDVO _$FileDVOFromJson(Map<String, dynamic> json) => FileDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      filename: json['filename'] as String,
      filesize: json['filesize'] as int,
      createdAt: json['createdAt'] as String,
      createdBy: IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdByDevice: json['createdByDevice'] as String,
      expiresAt: json['expiresAt'] as String,
      mimetype: json['mimetype'] as String,
      isOwn: json['isOwn'] as bool,
      title: json['title'] as String,
      secretKey: json['secretKey'] as String,
    );

Map<String, dynamic> _$FileDVOToJson(FileDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'filename': instance.filename,
      'filesize': instance.filesize,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'createdByDevice': instance.createdByDevice,
      'expiresAt': instance.expiresAt,
      'mimetype': instance.mimetype,
      'isOwn': instance.isOwn,
      'title': instance.title,
      'secretKey': instance.secretKey,
    };
