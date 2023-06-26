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
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      value: json['value'],
      valueType: json['valueType'] as String,
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      isDraft: json['isDraft'] as bool,
      isValid: json['isValid'] as bool,
      createdAt: json['createdAt'] as String,
      succeeds: json['succeeds'] as String?,
      succeededBy: json['succeededBy'] as String?,
      sharedWith: (json['sharedWith'] as List<dynamic>).map((e) => SharedToPeerAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$RepositoryAttributeDVOToJson(RepositoryAttributeDVO instance) {
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
  val['content'] = instance.content;
  val['owner'] = instance.owner;
  val['tags'] = instance.tags;
  writeNotNull('value', instance.value);
  val['valueType'] = instance.valueType;
  val['renderHints'] = instance.renderHints;
  val['valueHints'] = instance.valueHints;
  val['isDraft'] = instance.isDraft;
  val['isValid'] = instance.isValid;
  val['createdAt'] = instance.createdAt;
  writeNotNull('succeeds', instance.succeeds);
  writeNotNull('succeededBy', instance.succeededBy);
  val['sharedWith'] = instance.sharedWith;
  return val;
}

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
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      value: json['value'],
      valueType: json['valueType'] as String,
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      isDraft: json['isDraft'] as bool,
      isValid: json['isValid'] as bool,
      createdAt: json['createdAt'] as String,
      succeeds: json['succeeds'] as String?,
      succeededBy: json['succeededBy'] as String?,
      peer: json['peer'] as String,
      requestReference: json['requestReference'] as String,
      sourceAttribute: json['sourceAttribute'] as String,
    );

Map<String, dynamic> _$SharedToPeerAttributeDVOToJson(SharedToPeerAttributeDVO instance) {
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
  val['content'] = instance.content;
  val['owner'] = instance.owner;
  val['tags'] = instance.tags;
  writeNotNull('value', instance.value);
  val['valueType'] = instance.valueType;
  val['renderHints'] = instance.renderHints;
  val['valueHints'] = instance.valueHints;
  val['isDraft'] = instance.isDraft;
  val['isValid'] = instance.isValid;
  val['createdAt'] = instance.createdAt;
  writeNotNull('succeeds', instance.succeeds);
  writeNotNull('succeededBy', instance.succeededBy);
  val['peer'] = instance.peer;
  val['requestReference'] = instance.requestReference;
  val['sourceAttribute'] = instance.sourceAttribute;
  return val;
}

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
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      value: json['value'],
      valueType: json['valueType'] as String,
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      isDraft: json['isDraft'] as bool,
      isValid: json['isValid'] as bool,
      createdAt: json['createdAt'] as String,
      succeeds: json['succeeds'] as String?,
      succeededBy: json['succeededBy'] as String?,
      peer: json['peer'] as String,
      requestReference: json['requestReference'] as String,
    );

Map<String, dynamic> _$PeerAttributeDVOToJson(PeerAttributeDVO instance) {
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
  val['content'] = instance.content;
  val['owner'] = instance.owner;
  val['tags'] = instance.tags;
  writeNotNull('value', instance.value);
  val['valueType'] = instance.valueType;
  val['renderHints'] = instance.renderHints;
  val['valueHints'] = instance.valueHints;
  val['isDraft'] = instance.isDraft;
  val['isValid'] = instance.isValid;
  val['createdAt'] = instance.createdAt;
  writeNotNull('succeeds', instance.succeeds);
  writeNotNull('succeededBy', instance.succeededBy);
  val['peer'] = instance.peer;
  val['requestReference'] = instance.requestReference;
  return val;
}

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
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      value: json['value'],
      valueType: json['valueType'] as String,
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      isDraft: json['isDraft'] as bool,
      isValid: json['isValid'] as bool,
      createdAt: json['createdAt'] as String,
      succeeds: json['succeeds'] as String?,
      succeededBy: json['succeededBy'] as String?,
      key: json['key'] as String,
      peer: json['peer'] as String,
      requestReference: json['requestReference'] as String,
      confidentiality: json['confidentiality'] as String,
      isTechnical: json['isTechnical'] as bool,
    );

Map<String, dynamic> _$OwnRelationshipAttributeDVOToJson(OwnRelationshipAttributeDVO instance) {
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
  val['content'] = instance.content;
  val['owner'] = instance.owner;
  val['tags'] = instance.tags;
  writeNotNull('value', instance.value);
  val['valueType'] = instance.valueType;
  val['renderHints'] = instance.renderHints;
  val['valueHints'] = instance.valueHints;
  val['isDraft'] = instance.isDraft;
  val['isValid'] = instance.isValid;
  val['createdAt'] = instance.createdAt;
  writeNotNull('succeeds', instance.succeeds);
  writeNotNull('succeededBy', instance.succeededBy);
  val['key'] = instance.key;
  val['peer'] = instance.peer;
  val['requestReference'] = instance.requestReference;
  val['confidentiality'] = instance.confidentiality;
  val['isTechnical'] = instance.isTechnical;
  return val;
}

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
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      value: json['value'],
      valueType: json['valueType'] as String,
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      isDraft: json['isDraft'] as bool,
      isValid: json['isValid'] as bool,
      createdAt: json['createdAt'] as String,
      succeeds: json['succeeds'] as String?,
      succeededBy: json['succeededBy'] as String?,
      key: json['key'] as String,
      peer: json['peer'] as String,
      requestReference: json['requestReference'] as String,
      confidentiality: json['confidentiality'] as String,
      isTechnical: json['isTechnical'] as bool,
    );

Map<String, dynamic> _$PeerRelationshipAttributeDVOToJson(PeerRelationshipAttributeDVO instance) {
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
  val['content'] = instance.content;
  val['owner'] = instance.owner;
  val['tags'] = instance.tags;
  writeNotNull('value', instance.value);
  val['valueType'] = instance.valueType;
  val['renderHints'] = instance.renderHints;
  val['valueHints'] = instance.valueHints;
  val['isDraft'] = instance.isDraft;
  val['isValid'] = instance.isValid;
  val['createdAt'] = instance.createdAt;
  writeNotNull('succeeds', instance.succeeds);
  writeNotNull('succeededBy', instance.succeededBy);
  val['key'] = instance.key;
  val['peer'] = instance.peer;
  val['requestReference'] = instance.requestReference;
  val['confidentiality'] = instance.confidentiality;
  val['isTechnical'] = instance.isTechnical;
  return val;
}
