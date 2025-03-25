// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processed_attribute_query_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessedIdentityAttributeQueryDVO _$ProcessedIdentityAttributeQueryDVOFromJson(Map<String, dynamic> json) => ProcessedIdentityAttributeQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  results: (json['results'] as List<dynamic>).map((e) => IdentityAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  valueType: json['valueType'] as String,
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProcessedIdentityAttributeQueryDVOToJson(ProcessedIdentityAttributeQueryDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'results': instance.results.map((e) => e.toJson()).toList(),
  if (instance.tags case final value?) 'tags': value,
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
};

ProcessedRelationshipAttributeQueryDVO _$ProcessedRelationshipAttributeQueryDVOFromJson(Map<String, dynamic> json) =>
    ProcessedRelationshipAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>).map((e) => RelationshipAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
      key: json['key'] as String,
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      attributeCreationHints: RelationshipAttributeCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
      valueType: json['valueType'] as String,
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProcessedRelationshipAttributeQueryDVOToJson(ProcessedRelationshipAttributeQueryDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'results': instance.results.map((e) => e.toJson()).toList(),
  'key': instance.key,
  'owner': instance.owner.toJson(),
  'attributeCreationHints': instance.attributeCreationHints.toJson(),
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
};

ProcessedThirdPartyRelationshipAttributeQueryDVO _$ProcessedThirdPartyRelationshipAttributeQueryDVOFromJson(Map<String, dynamic> json) =>
    ProcessedThirdPartyRelationshipAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>).map((e) => RelationshipAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
      key: json['key'] as String,
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      thirdParty: (json['thirdParty'] as List<dynamic>).map((e) => IdentityDVO.fromJson(e as Map<String, dynamic>)).toList(),
      valueType: json['valueType'] as String?,
      renderHints: json['renderHints'] == null ? null : RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: json['valueHints'] == null ? null : ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProcessedThirdPartyRelationshipAttributeQueryDVOToJson(ProcessedThirdPartyRelationshipAttributeQueryDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'key': instance.key,
      'owner': instance.owner.toJson(),
      'thirdParty': instance.thirdParty.map((e) => e.toJson()).toList(),
      if (instance.valueType case final value?) 'valueType': value,
      if (instance.renderHints?.toJson() case final value?) 'renderHints': value,
      if (instance.valueHints?.toJson() case final value?) 'valueHints': value,
    };

ProcessedIQLQueryDVO _$ProcessedIQLQueryDVOFromJson(Map<String, dynamic> json) => ProcessedIQLQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  results: (json['results'] as List<dynamic>).map((e) => RepositoryAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
  valueType: json['valueType'] as String?,
  renderHints: json['renderHints'] == null ? null : RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: json['valueHints'] == null ? null : ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ProcessedIQLQueryDVOToJson(ProcessedIQLQueryDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'results': instance.results.map((e) => e.toJson()).toList(),
  if (instance.valueType case final value?) 'valueType': value,
  if (instance.renderHints?.toJson() case final value?) 'renderHints': value,
  if (instance.valueHints?.toJson() case final value?) 'valueHints': value,
  if (instance.tags case final value?) 'tags': value,
};
