// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityAttributeQuery _$IdentityAttributeQueryFromJson(Map<String, dynamic> json) =>
    IdentityAttributeQuery(valueType: json['valueType'] as String, tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList());

Map<String, dynamic> _$IdentityAttributeQueryToJson(IdentityAttributeQuery instance) => <String, dynamic>{
  'valueType': instance.valueType,
  if (instance.tags case final value?) 'tags': value,
};

IQLQuery _$IQLQueryFromJson(Map<String, dynamic> json) => IQLQuery(
  queryString: json['queryString'] as String,
  attributeCreationHints:
      json['attributeCreationHints'] == null ? null : IQLQueryCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IQLQueryToJson(IQLQuery instance) => <String, dynamic>{
  'queryString': instance.queryString,
  if (instance.attributeCreationHints?.toJson() case final value?) 'attributeCreationHints': value,
};

IQLQueryCreationHints _$IQLQueryCreationHintsFromJson(Map<String, dynamic> json) =>
    IQLQueryCreationHints(valueType: json['valueType'] as String, tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList());

Map<String, dynamic> _$IQLQueryCreationHintsToJson(IQLQueryCreationHints instance) => <String, dynamic>{
  'valueType': instance.valueType,
  if (instance.tags case final value?) 'tags': value,
};

RelationshipAttributeCreationHints _$RelationshipAttributeCreationHintsFromJson(Map<String, dynamic> json) => RelationshipAttributeCreationHints(
  title: json['title'] as String,
  valueType: json['valueType'] as String,
  description: json['description'] as String?,
  valueHints: json['valueHints'] == null ? null : ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  confidentiality: json['confidentiality'] as String,
);

Map<String, dynamic> _$RelationshipAttributeCreationHintsToJson(RelationshipAttributeCreationHints instance) => <String, dynamic>{
  'title': instance.title,
  'valueType': instance.valueType,
  if (instance.description case final value?) 'description': value,
  if (instance.valueHints?.toJson() case final value?) 'valueHints': value,
  'confidentiality': instance.confidentiality,
};

RelationshipAttributeQuery _$RelationshipAttributeQueryFromJson(Map<String, dynamic> json) => RelationshipAttributeQuery(
  key: json['key'] as String,
  owner: json['owner'] as String,
  attributeCreationHints: RelationshipAttributeCreationHints.fromJson(json['attributeCreationHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RelationshipAttributeQueryToJson(RelationshipAttributeQuery instance) => <String, dynamic>{
  'key': instance.key,
  'owner': instance.owner,
  'attributeCreationHints': instance.attributeCreationHints.toJson(),
};

ThirdPartyRelationshipAttributeQuery _$ThirdPartyRelationshipAttributeQueryFromJson(Map<String, dynamic> json) =>
    ThirdPartyRelationshipAttributeQuery(
      key: json['key'] as String,
      owner: $enumDecode(_$ThirdPartyRelationshipAttributeQueryOwnerEnumMap, json['owner']),
      thirdParty: (json['thirdParty'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ThirdPartyRelationshipAttributeQueryToJson(ThirdPartyRelationshipAttributeQuery instance) => <String, dynamic>{
  'key': instance.key,
  'owner': _$ThirdPartyRelationshipAttributeQueryOwnerEnumMap[instance.owner]!,
  'thirdParty': instance.thirdParty,
};

const _$ThirdPartyRelationshipAttributeQueryOwnerEnumMap = {
  ThirdPartyRelationshipAttributeQueryOwner.thirdParty: 'thirdParty',
  ThirdPartyRelationshipAttributeQueryOwner.recipient: 'recipient',
  ThirdPartyRelationshipAttributeQueryOwner.empty: '',
};
