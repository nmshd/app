// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_item_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseItemGroupDVO _$ResponseItemGroupDVOFromJson(Map<String, dynamic> json) =>
    ResponseItemGroupDVO(items: (json['items'] as List<dynamic>).map((e) => ResponseItemDVODerivation.fromJson(e as Map<String, dynamic>)).toList());

Map<String, dynamic> _$ResponseItemGroupDVOToJson(ResponseItemGroupDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

RejectResponseItemDVO _$RejectResponseItemDVOFromJson(Map<String, dynamic> json) => RejectResponseItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  code: json['code'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$RejectResponseItemDVOToJson(RejectResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  if (instance.code case final value?) 'code': value,
  if (instance.message case final value?) 'message': value,
};

ErrorResponseItemDVO _$ErrorResponseItemDVOFromJson(Map<String, dynamic> json) => ErrorResponseItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  code: json['code'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$ErrorResponseItemDVOToJson(ErrorResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'code': instance.code,
  'message': instance.message,
};

AcceptResponseItemDVO _$AcceptResponseItemDVOFromJson(Map<String, dynamic> json) => AcceptResponseItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AcceptResponseItemDVOToJson(AcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
};

ReadAttributeAcceptResponseItemDVO _$ReadAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) => ReadAttributeAcceptResponseItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  attributeId: json['attributeId'] as String,
  attribute: LocalAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
  thirdPartyAddress: json['thirdPartyAddress'] as String?,
);

Map<String, dynamic> _$ReadAttributeAcceptResponseItemDVOToJson(ReadAttributeAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
  if (instance.thirdPartyAddress case final value?) 'thirdPartyAddress': value,
};

ProposeAttributeAcceptResponseItemDVO _$ProposeAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    ProposeAttributeAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      attributeId: json['attributeId'] as String,
      attribute: LocalAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProposeAttributeAcceptResponseItemDVOToJson(ProposeAttributeAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
};

CreateAttributeAcceptResponseItemDVO _$CreateAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    CreateAttributeAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      attributeId: json['attributeId'] as String,
      attribute: LocalAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateAttributeAcceptResponseItemDVOToJson(CreateAttributeAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
};

DeleteAttributeAcceptResponseItemDVO _$DeleteAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    DeleteAttributeAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      deletionDate: json['deletionDate'] as String,
    );

Map<String, dynamic> _$DeleteAttributeAcceptResponseItemDVOToJson(DeleteAttributeAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'deletionDate': instance.deletionDate,
};

ShareAttributeAcceptResponseItemDVO _$ShareAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) => ShareAttributeAcceptResponseItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  attributeId: json['attributeId'] as String,
  attribute: LocalAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ShareAttributeAcceptResponseItemDVOToJson(ShareAttributeAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
};

FormFieldAcceptResponseItemDVO _$FormFieldAcceptResponseItemDVOFromJson(Map<String, dynamic> json) => FormFieldAcceptResponseItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  response: FormFieldAcceptResponseType.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FormFieldAcceptResponseItemDVOToJson(FormFieldAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'response': instance.response.toJson(),
};

FreeTextAcceptResponseItemDVO _$FreeTextAcceptResponseItemDVOFromJson(Map<String, dynamic> json) => FreeTextAcceptResponseItemDVO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  image: json['image'] as String?,
  type: json['type'] as String,
  date: json['date'] as String?,
  error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  freeText: json['freeText'] as String,
);

Map<String, dynamic> _$FreeTextAcceptResponseItemDVOToJson(FreeTextAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'freeText': instance.freeText,
};

RegisterAttributeListenerAcceptResponseItemDVO _$RegisterAttributeListenerAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    RegisterAttributeListenerAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      listenerId: json['listenerId'] as String,
      listener: LocalAttributeListenerDVO.fromJson(json['listener'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterAttributeListenerAcceptResponseItemDVOToJson(RegisterAttributeListenerAcceptResponseItemDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      'listenerId': instance.listenerId,
      'listener': instance.listener.toJson(),
    };

TransferFileOwnershipAcceptResponseItemDVO _$TransferFileOwnershipAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    TransferFileOwnershipAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      attributeId: json['attributeId'] as String,
      repositoryAttribute:
          json['repositoryAttribute'] == null ? null : LocalAttributeDVO.fromJson(json['repositoryAttribute'] as Map<String, dynamic>),
      sharedAttributeId: json['sharedAttributeId'] as String,
      sharedAttribute: LocalAttributeDVO.fromJson(json['sharedAttribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransferFileOwnershipAcceptResponseItemDVOToJson(TransferFileOwnershipAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'attributeId': instance.attributeId,
  if (instance.repositoryAttribute?.toJson() case final value?) 'repositoryAttribute': value,
  'sharedAttributeId': instance.sharedAttributeId,
  'sharedAttribute': instance.sharedAttribute.toJson(),
};

AttributeSuccessionAcceptResponseItemDVO _$AttributeSuccessionAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    AttributeSuccessionAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      predecessorId: json['predecessorId'] as String,
      successorId: json['successorId'] as String,
      predecessor: LocalAttributeDVO.fromJson(json['predecessor'] as Map<String, dynamic>),
      successor: LocalAttributeDVO.fromJson(json['successor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttributeSuccessionAcceptResponseItemDVOToJson(AttributeSuccessionAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'predecessorId': instance.predecessorId,
  'successorId': instance.successorId,
  'predecessor': instance.predecessor.toJson(),
  'successor': instance.successor.toJson(),
};

AttributeAlreadySharedAcceptResponseItemDVO _$AttributeAlreadySharedAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    AttributeAlreadySharedAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      attributeId: json['attributeId'] as String,
      attribute: LocalAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttributeAlreadySharedAcceptResponseItemDVOToJson(AttributeAlreadySharedAcceptResponseItemDVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.image case final value?) 'image': value,
  'type': instance.type,
  if (instance.date case final value?) 'date': value,
  if (instance.error?.toJson() case final value?) 'error': value,
  if (instance.warning?.toJson() case final value?) 'warning': value,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
};
