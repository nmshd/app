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
      status: $enumDecode(_$RelationshipStatusEnumMap, json['status']),
      peerDeletionStatus: $enumDecodeNullable(_$PeerDeletionStatusEnumMap, json['peerDeletionStatus']),
      peerDeletionDate: json['peerDeletionDate'] as String?,
      direction: $enumDecode(_$RelationshipDirectionEnumMap, json['direction']),
      statusText: json['statusText'] as String,
      isPinned: json['isPinned'] as bool,
      theme: json['theme'] == null ? null : RelationshipTheme.fromJson(json['theme'] as Map<String, dynamic>),
      creationContent: RelationshipCreationContentDerivation.fromJson(json['creationContent'] as Map<String, dynamic>),
      auditLog: (json['auditLog'] as List<dynamic>).map((e) => RelationshipAuditLogEntryDTO.fromJson(e as Map<String, dynamic>)).toList(),
      items: (json['items'] as List<dynamic>).map((e) => LocalAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
      attributeMap: (json['attributeMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as List<dynamic>).map((e) => LocalAttributeDVO.fromJson(e as Map<String, dynamic>)).toList()),
      ),
      nameMap: Map<String, String>.from(json['nameMap'] as Map),
      templateId: json['templateId'] as String,
      originalName: json['originalName'] as String?,
    );

Map<String, dynamic> _$RelationshipDVOToJson(RelationshipDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      'status': _$RelationshipStatusEnumMap[instance.status]!,
      if (_$PeerDeletionStatusEnumMap[instance.peerDeletionStatus] case final value?) 'peerDeletionStatus': value,
      if (instance.peerDeletionDate case final value?) 'peerDeletionDate': value,
      'direction': _$RelationshipDirectionEnumMap[instance.direction]!,
      'statusText': instance.statusText,
      'isPinned': instance.isPinned,
      if (instance.theme?.toJson() case final value?) 'theme': value,
      'creationContent': instance.creationContent.toJson(),
      'auditLog': instance.auditLog.map((e) => e.toJson()).toList(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'attributeMap': instance.attributeMap.map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'nameMap': instance.nameMap,
      'templateId': instance.templateId,
      if (instance.originalName case final value?) 'originalName': value,
    };

const _$RelationshipStatusEnumMap = {
  RelationshipStatus.Pending: 'Pending',
  RelationshipStatus.Active: 'Active',
  RelationshipStatus.Rejected: 'Rejected',
  RelationshipStatus.Revoked: 'Revoked',
  RelationshipStatus.Terminated: 'Terminated',
  RelationshipStatus.DeletionProposed: 'DeletionProposed',
};

const _$PeerDeletionStatusEnumMap = {
  PeerDeletionStatus.ToBeDeleted: 'ToBeDeleted',
  PeerDeletionStatus.Deleted: 'Deleted',
};

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

Map<String, dynamic> _$RelationshipThemeToJson(RelationshipTheme instance) => <String, dynamic>{
      if (instance.image case final value?) 'image': value,
      if (instance.headerImage case final value?) 'headerImage': value,
      if (instance.backgroundColor case final value?) 'backgroundColor': value,
      if (instance.foregroundColor case final value?) 'foregroundColor': value,
    };
