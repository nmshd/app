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

Map<String, dynamic> _$FileDVOToJson(FileDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['filename'] = instance.filename;
  val['filesize'] = instance.filesize;
  val['createdAt'] = instance.createdAt;
  val['createdBy'] = instance.createdBy;
  val['createdByDevice'] = instance.createdByDevice;
  val['expiresAt'] = instance.expiresAt;
  val['mimetype'] = instance.mimetype;
  val['isOwn'] = instance.isOwn;
  val['title'] = instance.title;
  val['secretKey'] = instance.secretKey;
  return val;
}
