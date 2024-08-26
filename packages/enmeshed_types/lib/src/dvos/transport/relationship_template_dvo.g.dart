// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_template_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipTemplateDVO _$RelationshipTemplateDVOFromJson(Map<String, dynamic> json) => RelationshipTemplateDVO(
      id: json['id'] as String,
      name: json['name'] as String,
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
      maxNumberOfAllocations: const OptionalIntegerConverter().fromJson(json['maxNumberOfAllocations']),
      onNewRelationship: json['onNewRelationship'] == null ? null : RequestDVO.fromJson(json['onNewRelationship'] as Map<String, dynamic>),
      onExistingRelationship:
          json['onExistingRelationship'] == null ? null : RequestDVO.fromJson(json['onExistingRelationship'] as Map<String, dynamic>),
      request: json['request'] == null ? null : LocalRequestDVO.fromJson(json['request'] as Map<String, dynamic>),
      content: RelationshipTemplateContentDerivation.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RelationshipTemplateDVOToJson(RelationshipTemplateDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isOwn'] = instance.isOwn;
  val['createdBy'] = instance.createdBy.toJson();
  val['createdByDevice'] = instance.createdByDevice;
  val['createdAt'] = instance.createdAt;
  writeNotNull('expiresAt', instance.expiresAt);
  writeNotNull('maxNumberOfAllocations', const OptionalIntegerConverter().toJson(instance.maxNumberOfAllocations));
  writeNotNull('onNewRelationship', instance.onNewRelationship?.toJson());
  writeNotNull('onExistingRelationship', instance.onExistingRelationship?.toJson());
  writeNotNull('request', instance.request?.toJson());
  val['content'] = instance.content.toJson();
  return val;
}
