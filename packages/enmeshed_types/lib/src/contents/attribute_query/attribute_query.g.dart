// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityAttributeQuery _$IdentityAttributeQueryFromJson(Map<String, dynamic> json) => IdentityAttributeQuery(
      valueType: json['valueType'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
    );

Map<String, dynamic> _$IdentityAttributeQueryToJson(IdentityAttributeQuery instance) {
  final val = <String, dynamic>{
    'valueType': instance.valueType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tags', instance.tags);
  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  return val;
}

IQLQuery _$IQLQueryFromJson(Map<String, dynamic> json) => IQLQuery(
      queryString: json['queryString'] as String,
      attributeCreationHints:
          json['attributeCreationHints'] == null ? null : IQLQueryCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IQLQueryToJson(IQLQuery instance) {
  final val = <String, dynamic>{
    'queryString': instance.queryString,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('attributeCreationHints', instance.attributeCreationHints?.toJson());
  return val;
}

IQLQueryCreationHints _$IQLQueryCreationHintsFromJson(Map<String, dynamic> json) => IQLQueryCreationHints(
      valueType: json['valueType'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$IQLQueryCreationHintsToJson(IQLQueryCreationHints instance) {
  final val = <String, dynamic>{
    'valueType': instance.valueType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tags', instance.tags);
  return val;
}

RelationshipAttributeCreationHints _$RelationshipAttributeCreationHintsFromJson(Map<String, dynamic> json) => RelationshipAttributeCreationHints(
      title: json['title'] as String,
      valueType: json['valueType'] as String,
      description: json['description'] as String?,
      valueHints: json['valueHints'] == null ? null : ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      confidentiality: json['confidentiality'] as String,
    );

Map<String, dynamic> _$RelationshipAttributeCreationHintsToJson(RelationshipAttributeCreationHints instance) {
  final val = <String, dynamic>{
    'title': instance.title,
    'valueType': instance.valueType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('valueHints', instance.valueHints?.toJson());
  val['confidentiality'] = instance.confidentiality;
  return val;
}

RelationshipAttributeQuery _$RelationshipAttributeQueryFromJson(Map<String, dynamic> json) => RelationshipAttributeQuery(
      key: json['key'] as String,
      owner: json['owner'] as String,
      attributeCreationHints: RelationshipAttributeCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
    );

Map<String, dynamic> _$RelationshipAttributeQueryToJson(RelationshipAttributeQuery instance) {
  final val = <String, dynamic>{
    'key': instance.key,
    'owner': instance.owner,
    'attributeCreationHints': instance.attributeCreationHints.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  return val;
}

ThirdPartyRelationshipAttributeQuery _$ThirdPartyRelationshipAttributeQueryFromJson(Map<String, dynamic> json) =>
    ThirdPartyRelationshipAttributeQuery(
      key: json['key'] as String,
      owner: json['owner'] as String,
      thirdParty: (json['thirdParty'] as List<dynamic>).map((e) => e as String).toList(),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
    );

Map<String, dynamic> _$ThirdPartyRelationshipAttributeQueryToJson(ThirdPartyRelationshipAttributeQuery instance) {
  final val = <String, dynamic>{
    'key': instance.key,
    'owner': instance.owner,
    'thirdParty': instance.thirdParty,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('validFrom', instance.validFrom);
  writeNotNull('validTo', instance.validTo);
  return val;
}
