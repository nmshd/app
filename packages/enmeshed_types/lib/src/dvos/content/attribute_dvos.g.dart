// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DraftIdentityAttributeDVO _$DraftIdentityAttributeDVOFromJson(Map<String, dynamic> json) => DraftIdentityAttributeDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
  owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  valueType: json['valueType'] as String,
  isOwn: json['isOwn'] as bool,
  isDraft: json['isDraft'] as bool,
  succeeds: json['succeeds'] as String?,
  succeededBy: json['succeededBy'] as String?,
  value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$DraftIdentityAttributeDVOToJson(DraftIdentityAttributeDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'content': instance.content.toJson(),
  'owner': instance.owner.toJson(),
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
  'valueType': instance.valueType,
  'isOwn': instance.isOwn,
  'isDraft': instance.isDraft,
  if (instance.succeeds case final value?) 'succeeds': value,
  if (instance.succeededBy case final value?) 'succeededBy': value,
  'value': instance.value.toJson(),
  'tags': instance.tags,
};

DraftRelationshipAttributeDVO _$DraftRelationshipAttributeDVOFromJson(Map<String, dynamic> json) => DraftRelationshipAttributeDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
  owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  valueType: json['valueType'] as String,
  isOwn: json['isOwn'] as bool,
  isDraft: json['isDraft'] as bool,
  succeeds: json['succeeds'] as String?,
  succeededBy: json['succeededBy'] as String?,
  value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
  key: json['key'] as String,
  isTechnical: json['isTechnical'] as bool,
  confidentiality: json['confidentiality'] as String,
);

Map<String, dynamic> _$DraftRelationshipAttributeDVOToJson(DraftRelationshipAttributeDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'content': instance.content.toJson(),
  'owner': instance.owner.toJson(),
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
  'valueType': instance.valueType,
  'isOwn': instance.isOwn,
  'isDraft': instance.isDraft,
  if (instance.succeeds case final value?) 'succeeds': value,
  if (instance.succeededBy case final value?) 'succeededBy': value,
  'value': instance.value.toJson(),
  'key': instance.key,
  'isTechnical': instance.isTechnical,
  'confidentiality': instance.confidentiality,
};
