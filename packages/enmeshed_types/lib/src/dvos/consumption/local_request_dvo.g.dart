// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_request_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalRequestDVO _$LocalRequestDVOFromJson(Map<String, dynamic> json) => LocalRequestDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      isOwn: json['isOwn'] as bool,
      createdAt: json['createdAt'] as String,
      content: RequestDVO.fromJson(json['content'] as Map<String, dynamic>),
      status: $enumDecode(_$LocalRequestStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      directionText: json['directionText'] as String,
      sourceTypeText: json['sourceTypeText'] as String,
      createdBy: IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
      peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
      response: json['response'] == null ? null : LocalResponseDVO.fromJson(json['response'] as Map<String, dynamic>),
      source: json['source'] == null ? null : LocalRequestSourceDVO.fromJson(json['source'] as Map<String, dynamic>),
      decider: IdentityDVO.fromJson(json['decider'] as Map<String, dynamic>),
      isDecidable: json['isDecidable'] as bool,
      items: (json['items'] as List<dynamic>).map((e) => RequestItemDVO.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$LocalRequestDVOToJson(LocalRequestDVO instance) {
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
  val['isOwn'] = instance.isOwn;
  val['createdAt'] = instance.createdAt;
  val['content'] = instance.content.toJson();
  val['status'] = _$LocalRequestStatusEnumMap[instance.status]!;
  val['statusText'] = instance.statusText;
  val['directionText'] = instance.directionText;
  val['sourceTypeText'] = instance.sourceTypeText;
  val['createdBy'] = instance.createdBy.toJson();
  val['peer'] = instance.peer.toJson();
  writeNotNull('response', instance.response?.toJson());
  writeNotNull('source', instance.source?.toJson());
  val['decider'] = instance.decider.toJson();
  val['isDecidable'] = instance.isDecidable;
  val['items'] = instance.items.map((e) => e.toJson()).toList();
  return val;
}

const _$LocalRequestStatusEnumMap = {
  LocalRequestStatus.Draft: 'Draft',
  LocalRequestStatus.Open: 'Open',
  LocalRequestStatus.DecisionRequired: 'DecisionRequired',
  LocalRequestStatus.ManualDecisionRequired: 'ManualDecisionRequired',
  LocalRequestStatus.Decided: 'Decided',
  LocalRequestStatus.Completed: 'Completed',
  LocalRequestStatus.Expired: 'Expired',
};

LocalRequestSourceDVO _$LocalRequestSourceDVOFromJson(Map<String, dynamic> json) => LocalRequestSourceDVO(
      type: $enumDecode(_$LocalRequestSourceTypeEnumMap, json['type']),
      reference: json['reference'] as String,
    );

Map<String, dynamic> _$LocalRequestSourceDVOToJson(LocalRequestSourceDVO instance) => <String, dynamic>{
      'type': _$LocalRequestSourceTypeEnumMap[instance.type]!,
      'reference': instance.reference,
    };

const _$LocalRequestSourceTypeEnumMap = {
  LocalRequestSourceType.Message: 'Message',
  LocalRequestSourceType.RelationshipTemplate: 'RelationshipTemplate',
};

LocalResponseDVO _$LocalResponseDVOFromJson(Map<String, dynamic> json) => LocalResponseDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      content: ResponseDVO.fromJson(json['content'] as Map<String, dynamic>),
      source: json['source'] == null ? null : LocalResponseSourceDVO.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocalResponseDVOToJson(LocalResponseDVO instance) {
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
  val['createdAt'] = instance.createdAt;
  val['content'] = instance.content.toJson();
  writeNotNull('source', instance.source?.toJson());
  return val;
}

LocalResponseSourceDVO _$LocalResponseSourceDVOFromJson(Map<String, dynamic> json) => LocalResponseSourceDVO(
      type: $enumDecode(_$LocalResponseSourceTypeEnumMap, json['type']),
      reference: json['reference'] as String,
    );

Map<String, dynamic> _$LocalResponseSourceDVOToJson(LocalResponseSourceDVO instance) => <String, dynamic>{
      'type': _$LocalResponseSourceTypeEnumMap[instance.type]!,
      'reference': instance.reference,
    };

const _$LocalResponseSourceTypeEnumMap = {
  LocalResponseSourceType.Message: 'Message',
  LocalResponseSourceType.Relationship: 'Relationship',
};
