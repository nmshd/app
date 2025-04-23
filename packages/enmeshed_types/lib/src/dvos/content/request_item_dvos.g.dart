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
  linkDisplayText: json['linkDisplayText'] as String?,
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
  if (instance.linkDisplayText case final value?) 'linkDisplayText': value,
};

FormFieldRequestItemDVO _$FormFieldRequestItemDVOFromJson(Map<String, dynamic> json) => FormFieldRequestItemDVO(
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
  settings: FormFieldSettings.fromJson(json['settings'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FormFieldRequestItemDVOToJson(FormFieldRequestItemDVO instance) => <String, dynamic>{
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
  'settings': instance.settings.toJson(),
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

TransferFileOwnershipRequestItemDVO _$TransferFileOwnershipRequestItemDVOFromJson(Map<String, dynamic> json) => TransferFileOwnershipRequestItemDVO(
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
  fileReference: json['fileReference'] as String,
  file: FileDVO.fromJson(json['file'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransferFileOwnershipRequestItemDVOToJson(TransferFileOwnershipRequestItemDVO instance) => <String, dynamic>{
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
  'fileReference': instance.fileReference,
  'file': instance.file.toJson(),
};
