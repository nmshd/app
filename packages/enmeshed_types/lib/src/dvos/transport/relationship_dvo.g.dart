// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipDVO _$RelationshipDVOFromJson(Map<String, dynamic> json) => RelationshipDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      status: json['status'] as String,
      direction: $enumDecode(_$RelationshipDirectionEnumMap, json['direction']),
      statusText: json['statusText'] as String,
      isPinned: json['isPinned'] as bool,
      theme: json['theme'] == null ? null : RelationshipTheme.fromJson(json['theme'] as Map<String, dynamic>),
      changes: (json['changes'] as List<dynamic>).map((e) => RelationshipChangeDVO.fromJson(e as Map<String, dynamic>)).toList(),
      changeCount: json['changeCount'] as int,
      items: (json['items'] as List<dynamic>).map((e) => LocalAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
      attributeMap: (json['attributeMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as List<dynamic>).map((e) => LocalAttributeDVO.fromJson(e as Map<String, dynamic>)).toList()),
      ),
      nameMap: Map<String, String>.from(json['nameMap'] as Map),
      templateId: json['templateId'] as String,
    );

Map<String, dynamic> _$RelationshipDVOToJson(RelationshipDVO instance) {
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
  val['status'] = instance.status;
  val['direction'] = _$RelationshipDirectionEnumMap[instance.direction]!;
  val['statusText'] = instance.statusText;
  val['isPinned'] = instance.isPinned;
  writeNotNull('theme', instance.theme);
  val['changes'] = instance.changes;
  val['changeCount'] = instance.changeCount;
  val['items'] = instance.items;
  val['attributeMap'] = instance.attributeMap;
  val['nameMap'] = instance.nameMap;
  val['templateId'] = instance.templateId;
  return val;
}

const _$RelationshipDirectionEnumMap = {
  RelationshipDirection.Incoming: 'Incoming',
  RelationshipDirection.Outgoing: 'Outgoing',
};

RelationshipTheme _$RelationshipThemeFromJson(Map<String, dynamic> json) => RelationshipTheme(
      image: json['image'] as String?,
      headerImage: json['headerImage'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
    );

Map<String, dynamic> _$RelationshipThemeToJson(RelationshipTheme instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image', instance.image);
  writeNotNull('headerImage', instance.headerImage);
  writeNotNull('backgroundColor', instance.backgroundColor);
  writeNotNull('foregroundColor', instance.foregroundColor);
  return val;
}

RelationshipChangeDVO _$RelationshipChangeDVOFromJson(Map<String, dynamic> json) => RelationshipChangeDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      request: RelationshipChangeRequestDVO.fromJson(json['request'] as Map<String, dynamic>),
      response: json['response'] == null ? null : RelationshipChangeResponseDVO.fromJson(json['response'] as Map<String, dynamic>),
      status: $enumDecode(_$RelationshipChangeStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      changeType: $enumDecode(_$RelationshipChangeTypeEnumMap, json['changeType']),
      changeTypeText: json['changeTypeText'] as String,
      isOwn: json['isOwn'] as bool,
    );

Map<String, dynamic> _$RelationshipChangeDVOToJson(RelationshipChangeDVO instance) {
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
  val['request'] = instance.request;
  writeNotNull('response', instance.response);
  val['status'] = _$RelationshipChangeStatusEnumMap[instance.status]!;
  val['statusText'] = instance.statusText;
  val['changeType'] = _$RelationshipChangeTypeEnumMap[instance.changeType]!;
  val['changeTypeText'] = instance.changeTypeText;
  val['isOwn'] = instance.isOwn;
  return val;
}

const _$RelationshipChangeStatusEnumMap = {
  RelationshipChangeStatus.Pending: 'Pending',
  RelationshipChangeStatus.Rejected: 'Rejected',
  RelationshipChangeStatus.Revoked: 'Revoked',
  RelationshipChangeStatus.Accepted: 'Accepted',
};

const _$RelationshipChangeTypeEnumMap = {
  RelationshipChangeType.Creation: 'Creation',
  RelationshipChangeType.Termination: 'Termination',
  RelationshipChangeType.TerminationCancellation: 'TerminationCancellation',
};

RelationshipChangeRequestDVO _$RelationshipChangeRequestDVOFromJson(Map<String, dynamic> json) => RelationshipChangeRequestDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      createdBy: json['createdBy'] as String,
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      content: json['content'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RelationshipChangeRequestDVOToJson(RelationshipChangeRequestDVO instance) {
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
  val['createdBy'] = instance.createdBy;
  val['createdByDevice'] = instance.createdByDevice;
  val['createdAt'] = instance.createdAt;
  writeNotNull('content', instance.content);
  return val;
}

RelationshipChangeResponseDVO _$RelationshipChangeResponseDVOFromJson(Map<String, dynamic> json) => RelationshipChangeResponseDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      createdBy: json['createdBy'] as String,
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      content: json['content'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RelationshipChangeResponseDVOToJson(RelationshipChangeResponseDVO instance) {
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
  val['createdBy'] = instance.createdBy;
  val['createdByDevice'] = instance.createdByDevice;
  val['createdAt'] = instance.createdAt;
  writeNotNull('content', instance.content);
  return val;
}
