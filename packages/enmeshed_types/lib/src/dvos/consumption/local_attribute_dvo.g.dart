// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_attribute_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryAttributeDVO _$RepositoryAttributeDVOFromJson(Map<String, dynamic> json) => RepositoryAttributeDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
  owner: json['owner'] as String,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
  valueType: json['valueType'] as String,
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  isDraft: json['isDraft'] as bool,
  isValid: json['isValid'] as bool,
  createdAt: json['createdAt'] as String,
  wasViewedAt: json['wasViewedAt'] as String?,
  succeeds: json['succeeds'] as String?,
  succeededBy: json['succeededBy'] as String?,
  sharedWith: (json['sharedWith'] as List<dynamic>).map((e) => SharedToPeerAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
  isDefault: json['isDefault'] as bool?,
);

Map<String, dynamic> _$RepositoryAttributeDVOToJson(RepositoryAttributeDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'content': instance.content.toJson(),
  'owner': instance.owner,
  'value': instance.value.toJson(),
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
  'isDraft': instance.isDraft,
  'isValid': instance.isValid,
  'createdAt': instance.createdAt,
  'wasViewedAt': ?instance.wasViewedAt,
  'succeeds': ?instance.succeeds,
  'succeededBy': ?instance.succeededBy,
  'tags': ?instance.tags,
  'sharedWith': instance.sharedWith.map((e) => e.toJson()).toList(),
  'isDefault': ?instance.isDefault,
};

SharedToPeerAttributeDVO _$SharedToPeerAttributeDVOFromJson(Map<String, dynamic> json) => SharedToPeerAttributeDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
  owner: json['owner'] as String,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
  valueType: json['valueType'] as String,
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  isDraft: json['isDraft'] as bool,
  isValid: json['isValid'] as bool,
  createdAt: json['createdAt'] as String,
  wasViewedAt: json['wasViewedAt'] as String?,
  succeeds: json['succeeds'] as String?,
  succeededBy: json['succeededBy'] as String?,
  peer: json['peer'] as String,
  requestReference: json['requestReference'] as String?,
  notificationReference: json['notificationReference'] as String?,
  sourceAttribute: json['sourceAttribute'] as String?,
  deletionDate: json['deletionDate'] as String?,
  deletionStatus: json['deletionStatus'] as String?,
);

Map<String, dynamic> _$SharedToPeerAttributeDVOToJson(SharedToPeerAttributeDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'content': instance.content.toJson(),
  'owner': instance.owner,
  'value': instance.value.toJson(),
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
  'isDraft': instance.isDraft,
  'isValid': instance.isValid,
  'createdAt': instance.createdAt,
  'wasViewedAt': ?instance.wasViewedAt,
  'succeeds': ?instance.succeeds,
  'succeededBy': ?instance.succeededBy,
  'tags': ?instance.tags,
  'peer': instance.peer,
  'requestReference': ?instance.requestReference,
  'notificationReference': ?instance.notificationReference,
  'sourceAttribute': ?instance.sourceAttribute,
  'deletionDate': ?instance.deletionDate,
  'deletionStatus': ?instance.deletionStatus,
};

PeerAttributeDVO _$PeerAttributeDVOFromJson(Map<String, dynamic> json) => PeerAttributeDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
  owner: json['owner'] as String,
  value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
  valueType: json['valueType'] as String,
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  isDraft: json['isDraft'] as bool,
  isValid: json['isValid'] as bool,
  createdAt: json['createdAt'] as String,
  wasViewedAt: json['wasViewedAt'] as String?,
  succeeds: json['succeeds'] as String?,
  succeededBy: json['succeededBy'] as String?,
  peer: json['peer'] as String,
  requestReference: json['requestReference'] as String?,
  notificationReference: json['notificationReference'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  deletionDate: json['deletionDate'] as String?,
  deletionStatus: json['deletionStatus'] as String?,
);

Map<String, dynamic> _$PeerAttributeDVOToJson(PeerAttributeDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'content': instance.content.toJson(),
  'owner': instance.owner,
  'value': instance.value.toJson(),
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
  'isDraft': instance.isDraft,
  'isValid': instance.isValid,
  'createdAt': instance.createdAt,
  'wasViewedAt': ?instance.wasViewedAt,
  'succeeds': ?instance.succeeds,
  'succeededBy': ?instance.succeededBy,
  'tags': ?instance.tags,
  'peer': instance.peer,
  'requestReference': ?instance.requestReference,
  'notificationReference': ?instance.notificationReference,
  'deletionDate': ?instance.deletionDate,
  'deletionStatus': ?instance.deletionStatus,
};

OwnRelationshipAttributeDVO _$OwnRelationshipAttributeDVOFromJson(Map<String, dynamic> json) => OwnRelationshipAttributeDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
  owner: json['owner'] as String,
  value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
  valueType: json['valueType'] as String,
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  isDraft: json['isDraft'] as bool,
  isValid: json['isValid'] as bool,
  createdAt: json['createdAt'] as String,
  wasViewedAt: json['wasViewedAt'] as String?,
  succeeds: json['succeeds'] as String?,
  succeededBy: json['succeededBy'] as String?,
  key: json['key'] as String,
  peer: json['peer'] as String,
  requestReference: json['requestReference'] as String?,
  notificationReference: json['notificationReference'] as String?,
  sourceAttribute: json['sourceAttribute'] as String?,
  thirdPartyAddress: json['thirdPartyAddress'] as String?,
  confidentiality: json['confidentiality'] as String,
  isTechnical: json['isTechnical'] as bool,
  deletionDate: json['deletionDate'] as String?,
  deletionStatus: json['deletionStatus'] as String?,
);

Map<String, dynamic> _$OwnRelationshipAttributeDVOToJson(OwnRelationshipAttributeDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'content': instance.content.toJson(),
  'owner': instance.owner,
  'value': instance.value.toJson(),
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
  'isDraft': instance.isDraft,
  'isValid': instance.isValid,
  'createdAt': instance.createdAt,
  'wasViewedAt': ?instance.wasViewedAt,
  'succeeds': ?instance.succeeds,
  'succeededBy': ?instance.succeededBy,
  'key': instance.key,
  'peer': instance.peer,
  'requestReference': ?instance.requestReference,
  'notificationReference': ?instance.notificationReference,
  'sourceAttribute': ?instance.sourceAttribute,
  'thirdPartyAddress': ?instance.thirdPartyAddress,
  'confidentiality': instance.confidentiality,
  'isTechnical': instance.isTechnical,
  'deletionDate': ?instance.deletionDate,
  'deletionStatus': ?instance.deletionStatus,
};

PeerRelationshipAttributeDVO _$PeerRelationshipAttributeDVOFromJson(Map<String, dynamic> json) => PeerRelationshipAttributeDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
  owner: json['owner'] as String,
  value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
  valueType: json['valueType'] as String,
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  isDraft: json['isDraft'] as bool,
  isValid: json['isValid'] as bool,
  createdAt: json['createdAt'] as String,
  wasViewedAt: json['wasViewedAt'] as String?,
  succeeds: json['succeeds'] as String?,
  succeededBy: json['succeededBy'] as String?,
  key: json['key'] as String,
  peer: json['peer'] as String,
  requestReference: json['requestReference'] as String?,
  notificationReference: json['notificationReference'] as String?,
  sourceAttribute: json['sourceAttribute'] as String?,
  thirdPartyAddress: json['thirdPartyAddress'] as String?,
  confidentiality: json['confidentiality'] as String,
  isTechnical: json['isTechnical'] as bool,
  deletionDate: json['deletionDate'] as String?,
  deletionStatus: json['deletionStatus'] as String?,
);

Map<String, dynamic> _$PeerRelationshipAttributeDVOToJson(PeerRelationshipAttributeDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'content': instance.content.toJson(),
  'owner': instance.owner,
  'value': instance.value.toJson(),
  'valueType': instance.valueType,
  'renderHints': instance.renderHints.toJson(),
  'valueHints': instance.valueHints.toJson(),
  'isDraft': instance.isDraft,
  'isValid': instance.isValid,
  'createdAt': instance.createdAt,
  'wasViewedAt': ?instance.wasViewedAt,
  'succeeds': ?instance.succeeds,
  'succeededBy': ?instance.succeededBy,
  'key': instance.key,
  'peer': instance.peer,
  'requestReference': ?instance.requestReference,
  'notificationReference': ?instance.notificationReference,
  'sourceAttribute': ?instance.sourceAttribute,
  'thirdPartyAddress': ?instance.thirdPartyAddress,
  'confidentiality': instance.confidentiality,
  'isTechnical': instance.isTechnical,
  'deletionDate': ?instance.deletionDate,
  'deletionStatus': ?instance.deletionStatus,
};
