// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_query_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityAttributeQueryDVO _$IdentityAttributeQueryDVOFromJson(Map<String, dynamic> json) => IdentityAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
      valueType: json['valueType'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isProcessed: json['isProcessed'] as bool,
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IdentityAttributeQueryDVOToJson(IdentityAttributeQueryDVO instance) {
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
  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  val['valueType'] = instance.valueType;
  writeNotNull('tags', instance.tags);
  val['isProcessed'] = instance.isProcessed;
  val['renderHints'] = instance.renderHints.toJson();
  val['valueHints'] = instance.valueHints.toJson();
  return val;
}

RelationshipAttributeQueryDVO _$RelationshipAttributeQueryDVOFromJson(Map<String, dynamic> json) => RelationshipAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
      valueType: json['valueType'] as String,
      key: json['key'] as String,
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      attributeCreationHints: RelationshipAttributeCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
      isProcessed: json['isProcessed'] as bool,
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RelationshipAttributeQueryDVOToJson(RelationshipAttributeQueryDVO instance) {
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
  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  val['valueType'] = instance.valueType;
  val['key'] = instance.key;
  val['owner'] = instance.owner.toJson();
  val['attributeCreationHints'] = instance.attributeCreationHints.toJson();
  val['isProcessed'] = instance.isProcessed;
  val['renderHints'] = instance.renderHints.toJson();
  val['valueHints'] = instance.valueHints.toJson();
  return val;
}

ThirdPartyRelationshipAttributeQueryDVO _$ThirdPartyRelationshipAttributeQueryDVOFromJson(Map<String, dynamic> json) =>
    ThirdPartyRelationshipAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
      key: json['key'] as String,
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      thirdParty: (json['thirdParty'] as List<dynamic>).map((e) => IdentityDVO.fromJson(e as Map<String, dynamic>)).toList(),
      isProcessed: json['isProcessed'] as bool,
    );

Map<String, dynamic> _$ThirdPartyRelationshipAttributeQueryDVOToJson(ThirdPartyRelationshipAttributeQueryDVO instance) {
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
  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  val['key'] = instance.key;
  val['owner'] = instance.owner.toJson();
  val['thirdParty'] = instance.thirdParty.map((e) => e.toJson()).toList();
  val['isProcessed'] = instance.isProcessed;
  return val;
}

IQLQueryDVO _$IQLQueryDVOFromJson(Map<String, dynamic> json) => IQLQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
      queryString: json['queryString'] as String,
      isProcessed: json['isProcessed'] as bool,
      valueType: json['valueType'] as String?,
      attributeCreationHints:
          json['attributeCreationHints'] == null ? null : IQLQueryCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
      renderHints: json['renderHints'] == null ? null : RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: json['valueHints'] == null ? null : ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$IQLQueryDVOToJson(IQLQueryDVO instance) {
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
  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  val['queryString'] = instance.queryString;
  val['isProcessed'] = instance.isProcessed;
  writeNotNull('valueType', instance.valueType);
  writeNotNull('attributeCreationHints', instance.attributeCreationHints?.toJson());
  writeNotNull('renderHints', instance.renderHints?.toJson());
  writeNotNull('valueHints', instance.valueHints?.toJson());
  writeNotNull('tags', instance.tags);
  return val;
}
