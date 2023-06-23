// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processed_attribute_query_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessedIdentityAttributeQueryDVO _$ProcessedIdentityAttributeQueryDVOFromJson(Map<String, dynamic> json) => ProcessedIdentityAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
    );

Map<String, dynamic> _$ProcessedIdentityAttributeQueryDVOToJson(ProcessedIdentityAttributeQueryDVO instance) {
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
  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  return val;
}

ProcessedRelationshipAttributeQueryDVO _$ProcessedRelationshipAttributeQueryDVOFromJson(Map<String, dynamic> json) =>
    ProcessedRelationshipAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
      results: (json['results'] as List<dynamic>).map((e) => RelationshipAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
      key: json['key'] as String,
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      attributeCreationHints: RelationshipAttributeCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
    )..type = json['type'] as String;

Map<String, dynamic> _$ProcessedRelationshipAttributeQueryDVOToJson(ProcessedRelationshipAttributeQueryDVO instance) {
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
  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  val['results'] = instance.results;
  val['key'] = instance.key;
  val['owner'] = instance.owner;
  val['attributeCreationHints'] = instance.attributeCreationHints;
  val['renderHints'] = instance.renderHints;
  val['valueHints'] = instance.valueHints;
  return val;
}

ProcessedThirdPartyRelationshipAttributeQueryDVO _$ProcessedThirdPartyRelationshipAttributeQueryDVOFromJson(Map<String, dynamic> json) =>
    ProcessedThirdPartyRelationshipAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
      results: (json['results'] as List<dynamic>).map((e) => RelationshipAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
      key: json['key'] as String,
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      attributeCreationHints: RelationshipAttributeCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
    )..type = json['type'] as String;

Map<String, dynamic> _$ProcessedThirdPartyRelationshipAttributeQueryDVOToJson(ProcessedThirdPartyRelationshipAttributeQueryDVO instance) {
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
  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  val['results'] = instance.results;
  val['key'] = instance.key;
  val['owner'] = instance.owner;
  val['attributeCreationHints'] = instance.attributeCreationHints;
  val['renderHints'] = instance.renderHints;
  val['valueHints'] = instance.valueHints;
  return val;
}
