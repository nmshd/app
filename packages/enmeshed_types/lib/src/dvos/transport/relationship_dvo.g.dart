// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipDVO _$RelationshipDVOFromJson(Map<String, dynamic> json) =>
    RelationshipDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null
          ? null
          : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null
          ? null
          : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      status: json['status'] as String,
      direction: $enumDecode(_$RelationshipDirectionEnumMap, json['direction']),
      statusText: json['statusText'] as String,
      isPinned: json['isPinned'] as bool,
      theme: json['theme'] == null
          ? null
          : RelationshipTheme.fromJson(json['theme'] as Map<String, dynamic>),
      changes: (json['changes'] as List<dynamic>)
          .map((e) => RelationshipChangeDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      changeCount: json['changeCount'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => LocalAttributeDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributeMap: (json['attributeMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) =>
                    LocalAttributeDVO.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      nameMap: Map<String, String>.from(json['nameMap'] as Map),
      templateId: json['templateId'] as String,
    );

Map<String, dynamic> _$RelationshipDVOToJson(RelationshipDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'status': instance.status,
      'direction': _$RelationshipDirectionEnumMap[instance.direction]!,
      'statusText': instance.statusText,
      'isPinned': instance.isPinned,
      'theme': instance.theme,
      'changes': instance.changes,
      'changeCount': instance.changeCount,
      'items': instance.items,
      'attributeMap': instance.attributeMap,
      'nameMap': instance.nameMap,
      'templateId': instance.templateId,
    };

const _$RelationshipDirectionEnumMap = {
  RelationshipDirection.Incoming: 'Incoming',
  RelationshipDirection.Outgoing: 'Outgoing',
};

RelationshipTheme _$RelationshipThemeFromJson(Map<String, dynamic> json) =>
    RelationshipTheme(
      image: json['image'] as String?,
      headerImage: json['headerImage'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
    );

Map<String, dynamic> _$RelationshipThemeToJson(RelationshipTheme instance) =>
    <String, dynamic>{
      'image': instance.image,
      'headerImage': instance.headerImage,
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
    };

RelationshipChangeDVO _$RelationshipChangeDVOFromJson(
        Map<String, dynamic> json) =>
    RelationshipChangeDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null
          ? null
          : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null
          ? null
          : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      request: RelationshipChangeRequestDVO.fromJson(
          json['request'] as Map<String, dynamic>),
      response: json['response'] == null
          ? null
          : RelationshipChangeResponseDVO.fromJson(
              json['response'] as Map<String, dynamic>),
      status: $enumDecode(_$RelationshipChangeStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      changeType:
          $enumDecode(_$RelationshipChangeTypeEnumMap, json['changeType']),
      changeTypeText: json['changeTypeText'] as String,
      isOwn: json['isOwn'] as bool,
    );

Map<String, dynamic> _$RelationshipChangeDVOToJson(
        RelationshipChangeDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'request': instance.request,
      'response': instance.response,
      'status': _$RelationshipChangeStatusEnumMap[instance.status]!,
      'statusText': instance.statusText,
      'changeType': _$RelationshipChangeTypeEnumMap[instance.changeType]!,
      'changeTypeText': instance.changeTypeText,
      'isOwn': instance.isOwn,
    };

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

RelationshipChangeRequestDVO _$RelationshipChangeRequestDVOFromJson(
        Map<String, dynamic> json) =>
    RelationshipChangeRequestDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null
          ? null
          : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null
          ? null
          : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      createdBy: json['createdBy'] as String,
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      content: json['content'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RelationshipChangeRequestDVOToJson(
        RelationshipChangeRequestDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'createdBy': instance.createdBy,
      'createdByDevice': instance.createdByDevice,
      'createdAt': instance.createdAt,
      'content': instance.content,
    };

RelationshipChangeResponseDVO _$RelationshipChangeResponseDVOFromJson(
        Map<String, dynamic> json) =>
    RelationshipChangeResponseDVO(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null
          ? null
          : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null
          ? null
          : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      createdBy: json['createdBy'] as String,
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      content: json['content'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RelationshipChangeResponseDVOToJson(
        RelationshipChangeResponseDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'createdBy': instance.createdBy,
      'createdByDevice': instance.createdByDevice,
      'createdAt': instance.createdAt,
      'content': instance.content,
    };
