// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_query_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityAttributeQueryDVO _$IdentityAttributeQueryDVOFromJson(
  Map<String, dynamic> json,
) => IdentityAttributeQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  validFrom: json['validFrom'] as String?,
  validTo: json['validTo'] as String?,
  valueType: json['valueType'] as String,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  isProcessed: json['isProcessed'] as bool,
  renderHints: RenderHints.fromJson(
    json['renderHints'] as Map<String, dynamic>,
  ),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IdentityAttributeQueryDVOToJson(
  IdentityAttributeQueryDVO instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'validFrom': ?instance.validFrom,
  'validTo': ?instance.validTo,
  'valueType': instance.valueType,
  'tags': ?instance.tags,
  'isProcessed': instance.isProcessed,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
};

RelationshipAttributeQueryDVO _$RelationshipAttributeQueryDVOFromJson(
  Map<String, dynamic> json,
) => RelationshipAttributeQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  validFrom: json['validFrom'] as String?,
  validTo: json['validTo'] as String?,
  valueType: json['valueType'] as String,
  key: json['key'] as String,
  owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
  attributeCreationHints: RelationshipAttributeCreationHints.fromJson(
    json['attributeCreationHints'] as Map<String, dynamic>,
  ),
  isProcessed: json['isProcessed'] as bool,
  renderHints: RenderHints.fromJson(
    json['renderHints'] as Map<String, dynamic>,
  ),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RelationshipAttributeQueryDVOToJson(
  RelationshipAttributeQueryDVO instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'validFrom': ?instance.validFrom,
  'validTo': ?instance.validTo,
  'valueType': instance.valueType,
  'key': instance.key,
  'owner': instance.owner.toJson(),
  'attributeCreationHints': instance.attributeCreationHints.toJson(),
  'isProcessed': instance.isProcessed,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
};

ThirdPartyRelationshipAttributeQueryDVO
_$ThirdPartyRelationshipAttributeQueryDVOFromJson(Map<String, dynamic> json) =>
    ThirdPartyRelationshipAttributeQueryDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null
          ? null
          : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null
          ? null
          : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      validFrom: json['validFrom'] as String?,
      validTo: json['validTo'] as String?,
      key: json['key'] as String,
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      thirdParty: (json['thirdParty'] as List<dynamic>)
          .map((e) => IdentityDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      isProcessed: json['isProcessed'] as bool,
    );

Map<String, dynamic> _$ThirdPartyRelationshipAttributeQueryDVOToJson(
  ThirdPartyRelationshipAttributeQueryDVO instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'validFrom': ?instance.validFrom,
  'validTo': ?instance.validTo,
  'key': instance.key,
  'owner': instance.owner.toJson(),
  'thirdParty': instance.thirdParty.map((e) => e.toJson()).toList(),
  'isProcessed': instance.isProcessed,
};

IQLQueryDVO _$IQLQueryDVOFromJson(Map<String, dynamic> json) => IQLQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  validFrom: json['validFrom'] as String?,
  validTo: json['validTo'] as String?,
  queryString: json['queryString'] as String,
  isProcessed: json['isProcessed'] as bool,
  valueType: json['valueType'] as String?,
  attributeCreationHints: json['attributeCreationHints'] == null
      ? null
      : IQLQueryCreationHints.fromJson(
          json['attributeCreationHints'] as Map<String, dynamic>,
        ),
  renderHints: json['renderHints'] == null
      ? null
      : RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: json['valueHints'] == null
      ? null
      : ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$IQLQueryDVOToJson(IQLQueryDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': ?instance.description,
      'image': ?instance.image,
      'type': instance.type,
      'date': ?instance.date,
      'error': ?instance.error?.toJson(),
      'warning': ?instance.warning?.toJson(),
      'validFrom': ?instance.validFrom,
      'validTo': ?instance.validTo,
      'queryString': instance.queryString,
      'isProcessed': instance.isProcessed,
      'valueType': ?instance.valueType,
      'attributeCreationHints': ?instance.attributeCreationHints?.toJson(),
      'renderHints': ?instance.renderHints?.toJson(),
      'valueHints': ?instance.valueHints?.toJson(),
      'tags': ?instance.tags,
    };

ProcessedIdentityAttributeQueryDVO _$ProcessedIdentityAttributeQueryDVOFromJson(
  Map<String, dynamic> json,
) => ProcessedIdentityAttributeQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  validFrom: json['validFrom'] as String?,
  validTo: json['validTo'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => IdentityAttributeDVO.fromJson(e as Map<String, dynamic>))
      .toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  valueType: json['valueType'] as String,
  renderHints: RenderHints.fromJson(
    json['renderHints'] as Map<String, dynamic>,
  ),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProcessedIdentityAttributeQueryDVOToJson(
  ProcessedIdentityAttributeQueryDVO instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'validFrom': ?instance.validFrom,
  'validTo': ?instance.validTo,
  'results': instance.results.map((e) => e.toJson()).toList(),
  'tags': ?instance.tags,
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
};

ProcessedRelationshipAttributeQueryDVO
_$ProcessedRelationshipAttributeQueryDVOFromJson(
  Map<String, dynamic> json,
) => ProcessedRelationshipAttributeQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  validFrom: json['validFrom'] as String?,
  validTo: json['validTo'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => RelationshipAttributeDVO.fromJson(e as Map<String, dynamic>))
      .toList(),
  key: json['key'] as String,
  owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
  attributeCreationHints: RelationshipAttributeCreationHints.fromJson(
    json['attributeCreationHints'] as Map<String, dynamic>,
  ),
  valueType: json['valueType'] as String,
  renderHints: RenderHints.fromJson(
    json['renderHints'] as Map<String, dynamic>,
  ),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProcessedRelationshipAttributeQueryDVOToJson(
  ProcessedRelationshipAttributeQueryDVO instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'validFrom': ?instance.validFrom,
  'validTo': ?instance.validTo,
  'results': instance.results.map((e) => e.toJson()).toList(),
  'key': instance.key,
  'owner': instance.owner.toJson(),
  'attributeCreationHints': instance.attributeCreationHints.toJson(),
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
};

ProcessedThirdPartyRelationshipAttributeQueryDVO
_$ProcessedThirdPartyRelationshipAttributeQueryDVOFromJson(
  Map<String, dynamic> json,
) => ProcessedThirdPartyRelationshipAttributeQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  validFrom: json['validFrom'] as String?,
  validTo: json['validTo'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => RelationshipAttributeDVO.fromJson(e as Map<String, dynamic>))
      .toList(),
  key: json['key'] as String,
  owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
  thirdParty: (json['thirdParty'] as List<dynamic>)
      .map((e) => IdentityDVO.fromJson(e as Map<String, dynamic>))
      .toList(),
  valueType: json['valueType'] as String?,
  renderHints: json['renderHints'] == null
      ? null
      : RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: json['valueHints'] == null
      ? null
      : ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProcessedThirdPartyRelationshipAttributeQueryDVOToJson(
  ProcessedThirdPartyRelationshipAttributeQueryDVO instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'validFrom': ?instance.validFrom,
  'validTo': ?instance.validTo,
  'results': instance.results.map((e) => e.toJson()).toList(),
  'key': instance.key,
  'owner': instance.owner.toJson(),
  'thirdParty': instance.thirdParty.map((e) => e.toJson()).toList(),
  'valueType': ?instance.valueType,
  'renderHints': ?instance.renderHints?.toJson(),
  'valueHints': ?instance.valueHints?.toJson(),
};

ProcessedIQLQueryDVO _$ProcessedIQLQueryDVOFromJson(
  Map<String, dynamic> json,
) => ProcessedIQLQueryDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  validFrom: json['validFrom'] as String?,
  validTo: json['validTo'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => RepositoryAttributeDVO.fromJson(e as Map<String, dynamic>))
      .toList(),
  valueType: json['valueType'] as String?,
  renderHints: json['renderHints'] == null
      ? null
      : RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: json['valueHints'] == null
      ? null
      : ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ProcessedIQLQueryDVOToJson(
  ProcessedIQLQueryDVO instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'validFrom': ?instance.validFrom,
  'validTo': ?instance.validTo,
  'results': instance.results.map((e) => e.toJson()).toList(),
  'valueType': ?instance.valueType,
  'renderHints': ?instance.renderHints?.toJson(),
  'valueHints': ?instance.valueHints?.toJson(),
  'tags': ?instance.tags,
};
