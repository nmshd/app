// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_template_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipTemplateDVO _$RelationshipTemplateDVOFromJson(Map<String, dynamic> json) => RelationshipTemplateDVO(
      type: json['type'] as String,
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
      content: json['content'],
    );

Map<String, dynamic> _$RelationshipTemplateDVOToJson(RelationshipTemplateDVO instance) {
  final val = <String, dynamic>{
    'type': instance.type,
    'isOwn': instance.isOwn,
    'createdBy': instance.createdBy,
    'createdByDevice': instance.createdByDevice,
    'createdAt': instance.createdAt,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expiresAt', instance.expiresAt);
  writeNotNull('maxNumberOfAllocations', instance.maxNumberOfAllocations);
  writeNotNull('onNewRelationship', instance.onNewRelationship);
  writeNotNull('onExistingRelationship', instance.onExistingRelationship);
  writeNotNull('request', instance.request);
  writeNotNull('content', instance.content);
  return val;
}
