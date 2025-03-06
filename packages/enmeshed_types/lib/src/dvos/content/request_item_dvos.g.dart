// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_item_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestItemGroupDVO _$RequestItemGroupDVOFromJson(Map<String, dynamic> json) => RequestItemGroupDVO(
  isDecidable: json['isDecidable'] as bool,
  items: (json['items'] as List<dynamic>).map((e) => RequestItemDVODerivation.fromJson(e as Map<String, dynamic>)).toList(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  response: json['response'] == null ? null : ResponseItemGroupDVO.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RequestItemGroupDVOToJson(RequestItemGroupDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  'items': instance.items.map((e) => e.toJson()).toList(),
  if (instance.title case final value?) 'title': value,
  if (instance.response?.toJson() case final value?) 'response': value,
};

ReadAttributeRequestItemDVO _$ReadAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => ReadAttributeRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  isDecidable: json['isDecidable'] as bool,
  response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
  requireManualDecision: json['requireManualDecision'] as bool?,
  query: AttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ReadAttributeRequestItemDVOToJson(ReadAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'query': instance.query.toJson(),
};

ProposeAttributeRequestItemDVO _$ProposeAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => ProposeAttributeRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  isDecidable: json['isDecidable'] as bool,
  response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
  requireManualDecision: json['requireManualDecision'] as bool?,
  query: AttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
  attribute: DraftAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
  proposedValueOverruled: json['proposedValueOverruled'] as bool,
);

Map<String, dynamic> _$ProposeAttributeRequestItemDVOToJson(ProposeAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'query': instance.query.toJson(),
  'attribute': instance.attribute.toJson(),
  'proposedValueOverruled': instance.proposedValueOverruled,
};

CreateAttributeRequestItemDVO _$CreateAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => CreateAttributeRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  isDecidable: json['isDecidable'] as bool,
  response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
  requireManualDecision: json['requireManualDecision'] as bool?,
  attribute: DraftAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
  sourceAttributeId: json['sourceAttributeId'] as String?,
);

Map<String, dynamic> _$CreateAttributeRequestItemDVOToJson(CreateAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'attribute': instance.attribute.toJson(),
  if (instance.sourceAttributeId case final value?) 'sourceAttributeId': value,
};

DeleteAttributeRequestItemDVO _$DeleteAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => DeleteAttributeRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  isDecidable: json['isDecidable'] as bool,
  response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
  requireManualDecision: json['requireManualDecision'] as bool?,
  attributeId: json['attributeId'] as String,
  attribute: LocalAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DeleteAttributeRequestItemDVOToJson(DeleteAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
};

ShareAttributeRequestItemDVO _$ShareAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => ShareAttributeRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  isDecidable: json['isDecidable'] as bool,
  response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
  requireManualDecision: json['requireManualDecision'] as bool?,
  attribute: DraftIdentityAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
  sourceAttributeId: json['sourceAttributeId'] as String,
  thirdPartyAddress: json['thirdPartyAddress'] as String?,
);

Map<String, dynamic> _$ShareAttributeRequestItemDVOToJson(ShareAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'attribute': instance.attribute.toJson(),
  'sourceAttributeId': instance.sourceAttributeId,
  if (instance.thirdPartyAddress case final value?) 'thirdPartyAddress': value,
};

AuthenticationRequestItemDVO _$AuthenticationRequestItemDVOFromJson(Map<String, dynamic> json) => AuthenticationRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  isDecidable: json['isDecidable'] as bool,
  response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
  requireManualDecision: json['requireManualDecision'] as bool?,
  title: json['title'] as String,
);

Map<String, dynamic> _$AuthenticationRequestItemDVOToJson(AuthenticationRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'title': instance.title,
};

ConsentRequestItemDVO _$ConsentRequestItemDVOFromJson(Map<String, dynamic> json) => ConsentRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  isDecidable: json['isDecidable'] as bool,
  response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
  requireManualDecision: json['requireManualDecision'] as bool?,
  consent: json['consent'] as String,
  link: json['link'] as String?,
);

Map<String, dynamic> _$ConsentRequestItemDVOToJson(ConsentRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'consent': instance.consent,
  if (instance.link case final value?) 'link': value,
};

FreeTextRequestItemDVO _$FreeTextRequestItemDVOFromJson(Map<String, dynamic> json) => FreeTextRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  isDecidable: json['isDecidable'] as bool,
  response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
  requireManualDecision: json['requireManualDecision'] as bool?,
  freeText: json['freeText'] as String,
);

Map<String, dynamic> _$FreeTextRequestItemDVOToJson(FreeTextRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'freeText': instance.freeText,
};

RegisterAttributeListenerRequestItemDVO _$RegisterAttributeListenerRequestItemDVOFromJson(Map<String, dynamic> json) =>
    RegisterAttributeListenerRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      mustBeAccepted: json['mustBeAccepted'] as bool,
      isDecidable: json['isDecidable'] as bool,
      response: json['response'] == null ? null : ResponseItemDVO.fromJson(json['response'] as Map<String, dynamic>),
      requireManualDecision: json['requireManualDecision'] as bool?,
      query: AttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterAttributeListenerRequestItemDVOToJson(RegisterAttributeListenerRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'isDecidable': instance.isDecidable,
  if (instance.response?.toJson() case final value?) 'response': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'query': instance.query.toJson(),
};

DecidableReadAttributeRequestItemDVO _$DecidableReadAttributeRequestItemDVOFromJson(Map<String, dynamic> json) =>
    DecidableReadAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      mustBeAccepted: json['mustBeAccepted'] as bool,
      query: ProcessedAttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
      requireManualDecision: json['requireManualDecision'] as bool?,
    );

Map<String, dynamic> _$DecidableReadAttributeRequestItemDVOToJson(DecidableReadAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'query': instance.query.toJson(),
};

DecidableProposeAttributeRequestItemDVO _$DecidableProposeAttributeRequestItemDVOFromJson(Map<String, dynamic> json) =>
    DecidableProposeAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      mustBeAccepted: json['mustBeAccepted'] as bool,
      requireManualDecision: json['requireManualDecision'] as bool?,
      query: ProcessedAttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
      attribute: DraftAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DecidableProposeAttributeRequestItemDVOToJson(DecidableProposeAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'query': instance.query.toJson(),
  'attribute': instance.attribute.toJson(),
};

DecidableCreateAttributeRequestItemDVO _$DecidableCreateAttributeRequestItemDVOFromJson(Map<String, dynamic> json) =>
    DecidableCreateAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      mustBeAccepted: json['mustBeAccepted'] as bool,
      requireManualDecision: json['requireManualDecision'] as bool?,
      attribute: DraftAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DecidableCreateAttributeRequestItemDVOToJson(DecidableCreateAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'attribute': instance.attribute.toJson(),
};

DecidableDeleteAttributeRequestItemDVO _$DecidableDeleteAttributeRequestItemDVOFromJson(Map<String, dynamic> json) =>
    DecidableDeleteAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      mustBeAccepted: json['mustBeAccepted'] as bool,
      requireManualDecision: json['requireManualDecision'] as bool?,
      attributeId: json['attributeId'] as String,
      attribute: LocalAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DecidableDeleteAttributeRequestItemDVOToJson(DecidableDeleteAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
};

DecidableShareAttributeRequestItemDVO _$DecidableShareAttributeRequestItemDVOFromJson(Map<String, dynamic> json) =>
    DecidableShareAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      mustBeAccepted: json['mustBeAccepted'] as bool,
      requireManualDecision: json['requireManualDecision'] as bool?,
      sourceAttributeId: json['sourceAttributeId'] as String,
      attribute: DraftAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
      thirdPartyAddress: json['thirdPartyAddress'] as String?,
    );

Map<String, dynamic> _$DecidableShareAttributeRequestItemDVOToJson(DecidableShareAttributeRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'sourceAttributeId': instance.sourceAttributeId,
  'attribute': instance.attribute.toJson(),
  if (instance.thirdPartyAddress case final value?) 'thirdPartyAddress': value,
};

DecidableAuthenticationRequestItemDVO _$DecidableAuthenticationRequestItemDVOFromJson(Map<String, dynamic> json) =>
    DecidableAuthenticationRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      mustBeAccepted: json['mustBeAccepted'] as bool,
      requireManualDecision: json['requireManualDecision'] as bool?,
      title: json['title'] as String,
    );

Map<String, dynamic> _$DecidableAuthenticationRequestItemDVOToJson(DecidableAuthenticationRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'title': instance.title,
};

DecidableConsentRequestItemDVO _$DecidableConsentRequestItemDVOFromJson(Map<String, dynamic> json) => DecidableConsentRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  consent: json['consent'] as String,
  link: json['link'] as String?,
);

Map<String, dynamic> _$DecidableConsentRequestItemDVOToJson(DecidableConsentRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'consent': instance.consent,
  if (instance.link case final value?) 'link': value,
};

DecidableFreeTextRequestItemDVO _$DecidableFreeTextRequestItemDVOFromJson(Map<String, dynamic> json) => DecidableFreeTextRequestItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  freeText: json['freeText'] as String,
);

Map<String, dynamic> _$DecidableFreeTextRequestItemDVOToJson(DecidableFreeTextRequestItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'freeText': instance.freeText,
};

DecidableRegisterAttributeListenerRequestItemDVO _$DecidableRegisterAttributeListenerRequestItemDVOFromJson(Map<String, dynamic> json) =>
    DecidableRegisterAttributeListenerRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      mustBeAccepted: json['mustBeAccepted'] as bool,
      requireManualDecision: json['requireManualDecision'] as bool?,
      query: AttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DecidableRegisterAttributeListenerRequestItemDVOToJson(DecidableRegisterAttributeListenerRequestItemDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      'mustBeAccepted': instance.mustBeAccepted,
      if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
      'query': instance.query.toJson(),
    };
