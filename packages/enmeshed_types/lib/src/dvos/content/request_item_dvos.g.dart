// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_item_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestItemGroupDVO _$RequestItemGroupDVOFromJson(Map<String, dynamic> json) => RequestItemGroupDVO(
      items: (json['items'] as List<dynamic>).map((e) => RequestItemDVODerivation.fromJson(e as Map<String, dynamic>)).toList(),
      title: json['title'] as String?,
      isDecidable: json['isDecidable'] as bool,
      mustBeAccepted: json['mustBeAccepted'] as bool,
      response: json['response'] == null ? null : ResponseItemGroupDVO.fromJson(json['response'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..name = json['name'] as String?
      ..description = json['description'] as String?
      ..image = json['image'] as String?
      ..type = json['type'] as String
      ..date = json['date'] as String?
      ..error = json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>)
      ..warning = json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>);

Map<String, dynamic> _$RequestItemGroupDVOToJson(RequestItemGroupDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['items'] = instance.items;
  writeNotNull('title', instance.title);
  val['isDecidable'] = instance.isDecidable;
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('response', instance.response);
  return val;
}

ReadAttributeRequestItemDVO _$ReadAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => ReadAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      query: AttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
    )..type = json['type'] as String;

Map<String, dynamic> _$ReadAttributeRequestItemDVOToJson(ReadAttributeRequestItemDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['query'] = instance.query;
  return val;
}

ProposeAttributeRequestItemDVO _$ProposeAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => ProposeAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      query: AttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
      attribute: DraftAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
    )..type = json['type'] as String;

Map<String, dynamic> _$ProposeAttributeRequestItemDVOToJson(ProposeAttributeRequestItemDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['query'] = instance.query;
  val['attribute'] = instance.attribute;
  return val;
}

CreateAttributeRequestItemDVO _$CreateAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => CreateAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      attribute: DraftAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
      sourceAttributeId: json['sourceAttributeId'] as String?,
    )..type = json['type'] as String;

Map<String, dynamic> _$CreateAttributeRequestItemDVOToJson(CreateAttributeRequestItemDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['attribute'] = instance.attribute;
  writeNotNull('sourceAttributeId', instance.sourceAttributeId);
  return val;
}

ShareAttributeRequestItemDVO _$ShareAttributeRequestItemDVOFromJson(Map<String, dynamic> json) => ShareAttributeRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      attribute: DraftIdentityAttributeDVO.fromJson(json['attribute'] as Map<String, dynamic>),
      sourceAttributeId: json['sourceAttributeId'] as String,
    )..type = json['type'] as String;

Map<String, dynamic> _$ShareAttributeRequestItemDVOToJson(ShareAttributeRequestItemDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['attribute'] = instance.attribute;
  val['sourceAttributeId'] = instance.sourceAttributeId;
  return val;
}

AuthenticationRequestItemDVO _$AuthenticationRequestItemDVOFromJson(Map<String, dynamic> json) => AuthenticationRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
    )..type = json['type'] as String;

Map<String, dynamic> _$AuthenticationRequestItemDVOToJson(AuthenticationRequestItemDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  return val;
}

ConsentRequestItemDVO _$ConsentRequestItemDVOFromJson(Map<String, dynamic> json) => ConsentRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      consent: json['consent'] as String,
      link: json['link'] as String?,
    )..type = json['type'] as String;

Map<String, dynamic> _$ConsentRequestItemDVOToJson(ConsentRequestItemDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['consent'] = instance.consent;
  writeNotNull('link', instance.link);
  return val;
}

RegisterAttributeListenerRequestItemDVO _$RegisterAttributeListenerRequestItemDVOFromJson(Map<String, dynamic> json) =>
    RegisterAttributeListenerRequestItemDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      query: AttributeQueryDVO.fromJson(json['query'] as Map<String, dynamic>),
    )..type = json['type'] as String;

Map<String, dynamic> _$RegisterAttributeListenerRequestItemDVOToJson(RegisterAttributeListenerRequestItemDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error);
  writeNotNull('warning', instance.warning);
  val['query'] = instance.query;
  return val;
}
