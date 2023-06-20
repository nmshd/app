// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_item_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseItemGroupDVO _$ResponseItemGroupDVOFromJson(Map<String, dynamic> json) => ResponseItemGroupDVO(
      items: (json['items'] as List<dynamic>).map((e) => ResponseItemDVODerivation.fromJson(e as Map<String, dynamic>)).toList(),
    )
      ..id = json['id'] as String
      ..name = json['name'] as String?
      ..description = json['description'] as String?
      ..image = json['image'] as String?
      ..type = json['type'] as String
      ..date = json['date'] as String?
      ..error = json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>)
      ..warning = json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>);

Map<String, dynamic> _$ResponseItemGroupDVOToJson(ResponseItemGroupDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'items': instance.items,
    };

RejectResponseItemDVO _$RejectResponseItemDVOFromJson(Map<String, dynamic> json) => RejectResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
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
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'code': instance.code,
      'message': instance.message,
    };

ErrorResponseItemDVO _$ErrorResponseItemDVOFromJson(Map<String, dynamic> json) => ErrorResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
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
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'code': instance.code,
      'message': instance.message,
    };

AcceptResponseItemDVO _$AcceptResponseItemDVOFromJson(Map<String, dynamic> json) => AcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
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
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
    };

ReadAttributeAcceptResponseItemDVO _$ReadAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) => ReadAttributeAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      attributeId: json['attributeId'] as String,
      attribute: LocalAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReadAttributeAcceptResponseItemDVOToJson(ReadAttributeAcceptResponseItemDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'attributeId': instance.attributeId,
      'attribute': instance.attribute,
    };

ProposeAttributeAcceptResponseItemDVO _$ProposeAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    ProposeAttributeAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
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
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'attributeId': instance.attributeId,
      'attribute': instance.attribute,
    };

CreateAttributeAcceptResponseItemDVO _$CreateAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    CreateAttributeAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
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
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'attributeId': instance.attributeId,
      'attribute': instance.attribute,
    };

ShareAttributeAcceptResponseItemDVO _$ShareAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic> json) => ShareAttributeAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
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
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'attributeId': instance.attributeId,
      'attribute': instance.attribute,
    };

RegisterAttributeListenerAcceptResponseItemDVO _$RegisterAttributeListenerAcceptResponseItemDVOFromJson(Map<String, dynamic> json) =>
    RegisterAttributeListenerAcceptResponseItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
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
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'listenerId': instance.listenerId,
      'listener': instance.listener,
    };
