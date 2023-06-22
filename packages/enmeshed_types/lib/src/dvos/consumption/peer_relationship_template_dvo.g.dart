// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_relationship_template_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerRelationshipTemplateDVO _$PeerRelationshipTemplateDVOFromJson(Map<String, dynamic> json) => PeerRelationshipTemplateDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      isOwn: json['isOwn'] as bool,
      createdBy: IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      expiresAt: json['expiresAt'] as String?,
      maxNumberOfAllocations: json['maxNumberOfAllocations'] as int?,
      onNewRelationship: json['onNewRelationship'] == null ? null : RequestDVO.fromJson(json['onNewRelationship'] as Map<String, dynamic>),
      onExistingRelationship:
          json['onExistingRelationship'] == null ? null : RequestDVO.fromJson(json['onExistingRelationship'] as Map<String, dynamic>),
      request: json['request'] == null ? null : LocalRequestDVO.fromJson(json['request'] as Map<String, dynamic>),
      content: json['content'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PeerRelationshipTemplateDVOToJson(PeerRelationshipTemplateDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['isOwn'] = instance.isOwn;
  val['createdBy'] = instance.createdBy;
  val['createdByDevice'] = instance.createdByDevice;
  val['createdAt'] = instance.createdAt;
  writeNotNull('expiresAt', instance.expiresAt);
  writeNotNull('maxNumberOfAllocations', instance.maxNumberOfAllocations);
  writeNotNull('onNewRelationship', instance.onNewRelationship);
  writeNotNull('onExistingRelationship', instance.onExistingRelationship);
  writeNotNull('request', instance.request);
  val['content'] = instance.content;
  return val;
}
