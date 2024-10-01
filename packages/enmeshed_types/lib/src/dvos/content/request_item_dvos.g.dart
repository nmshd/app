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

Map<String, dynamic> _$RequestItemGroupDVOToJson(RequestItemGroupDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  val['items'] = instance.items.map((e) => e.toJson()).toList();
  writeNotNull('title', instance.title);
  writeNotNull('response', instance.response?.toJson());
  return val;
}

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

Map<String, dynamic> _$ReadAttributeRequestItemDVOToJson(ReadAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['query'] = instance.query.toJson();
  return val;
}

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

Map<String, dynamic> _$ProposeAttributeRequestItemDVOToJson(ProposeAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['query'] = instance.query.toJson();
  val['attribute'] = instance.attribute.toJson();
  val['proposedValueOverruled'] = instance.proposedValueOverruled;
  return val;
}

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

Map<String, dynamic> _$CreateAttributeRequestItemDVOToJson(CreateAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['attribute'] = instance.attribute.toJson();
  writeNotNull('sourceAttributeId', instance.sourceAttributeId);
  return val;
}

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

Map<String, dynamic> _$DeleteAttributeRequestItemDVOToJson(DeleteAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['attributeId'] = instance.attributeId;
  val['attribute'] = instance.attribute.toJson();
  return val;
}

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
    );

Map<String, dynamic> _$ShareAttributeRequestItemDVOToJson(ShareAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['attribute'] = instance.attribute.toJson();
  val['sourceAttributeId'] = instance.sourceAttributeId;
  return val;
}

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

Map<String, dynamic> _$AuthenticationRequestItemDVOToJson(AuthenticationRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  return val;
}

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

Map<String, dynamic> _$ConsentRequestItemDVOToJson(ConsentRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['consent'] = instance.consent;
  writeNotNull('link', instance.link);
  return val;
}

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

Map<String, dynamic> _$FreeTextRequestItemDVOToJson(FreeTextRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['freeText'] = instance.freeText;
  return val;
}

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

Map<String, dynamic> _$RegisterAttributeListenerRequestItemDVOToJson(RegisterAttributeListenerRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['isDecidable'] = instance.isDecidable;
  writeNotNull('response', instance.response?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['query'] = instance.query.toJson();
  return val;
}

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

Map<String, dynamic> _$DecidableReadAttributeRequestItemDVOToJson(DecidableReadAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['query'] = instance.query.toJson();
  return val;
}

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

Map<String, dynamic> _$DecidableProposeAttributeRequestItemDVOToJson(DecidableProposeAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['query'] = instance.query.toJson();
  val['attribute'] = instance.attribute.toJson();
  return val;
}

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

Map<String, dynamic> _$DecidableCreateAttributeRequestItemDVOToJson(DecidableCreateAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['attribute'] = instance.attribute.toJson();
  return val;
}

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

Map<String, dynamic> _$DecidableDeleteAttributeRequestItemDVOToJson(DecidableDeleteAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['attributeId'] = instance.attributeId;
  val['attribute'] = instance.attribute.toJson();
  return val;
}

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
    );

Map<String, dynamic> _$DecidableShareAttributeRequestItemDVOToJson(DecidableShareAttributeRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['sourceAttributeId'] = instance.sourceAttributeId;
  val['attribute'] = instance.attribute.toJson();
  return val;
}

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
    );

Map<String, dynamic> _$DecidableAuthenticationRequestItemDVOToJson(DecidableAuthenticationRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  return val;
}

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

Map<String, dynamic> _$DecidableConsentRequestItemDVOToJson(DecidableConsentRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['consent'] = instance.consent;
  writeNotNull('link', instance.link);
  return val;
}

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

Map<String, dynamic> _$DecidableFreeTextRequestItemDVOToJson(DecidableFreeTextRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['freeText'] = instance.freeText;
  return val;
}

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

Map<String, dynamic> _$DecidableRegisterAttributeListenerRequestItemDVOToJson(DecidableRegisterAttributeListenerRequestItemDVO instance) {
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['mustBeAccepted'] = instance.mustBeAccepted;
  writeNotNull('requireManualDecision', instance.requireManualDecision);
  val['query'] = instance.query.toJson();
  return val;
}
