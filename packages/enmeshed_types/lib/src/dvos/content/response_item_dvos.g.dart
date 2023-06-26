// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_item_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseItemGroupDVO _$ResponseItemGroupDVOFromJson(Map<String, dynamic> json) => ResponseItemGroupDVO(
      items: (json['items'] as List<dynamic>).map((e) => ResponseItemDVODerivation.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$ResponseItemGroupDVOToJson(ResponseItemGroupDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['items'] = instance.items;
  return val;
}

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

Map<String, dynamic> _$RejectResponseItemDVOToJson(RejectResponseItemDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  writeNotNull('code', instance.code);
  writeNotNull('message', instance.message);
  return val;
}

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

Map<String, dynamic> _$ErrorResponseItemDVOToJson(ErrorResponseItemDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['code'] = instance.code;
  val['message'] = instance.message;
  return val;
}

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

Map<String, dynamic> _$AcceptResponseItemDVOToJson(AcceptResponseItemDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  return val;
}

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
    );

Map<String, dynamic> _$ReadAttributeAcceptResponseItemDVOToJson(ReadAttributeAcceptResponseItemDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['attributeId'] = instance.attributeId;
  val['attribute'] = instance.attribute;
  return val;
}

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

Map<String, dynamic> _$ProposeAttributeAcceptResponseItemDVOToJson(ProposeAttributeAcceptResponseItemDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['attributeId'] = instance.attributeId;
  val['attribute'] = instance.attribute;
  return val;
}

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

Map<String, dynamic> _$CreateAttributeAcceptResponseItemDVOToJson(CreateAttributeAcceptResponseItemDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['attributeId'] = instance.attributeId;
  val['attribute'] = instance.attribute;
  return val;
}

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

Map<String, dynamic> _$ShareAttributeAcceptResponseItemDVOToJson(ShareAttributeAcceptResponseItemDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['attributeId'] = instance.attributeId;
  val['attribute'] = instance.attribute;
  return val;
}

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

Map<String, dynamic> _$RegisterAttributeListenerAcceptResponseItemDVOToJson(RegisterAttributeListenerAcceptResponseItemDVO instance) {
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
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['listenerId'] = instance.listenerId;
  val['listener'] = instance.listener;
  return val;
}
