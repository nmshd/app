// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDVO _$MessageDVOFromJson(Map<String, dynamic> json) => MessageDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      createdBy: IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
      recipients: (json['recipients'] as List<dynamic>).map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>)).toList(),
      attachments: (json['attachments'] as List<dynamic>).map((e) => FileDVO.fromJson(e as Map<String, dynamic>)).toList(),
      isOwn: json['isOwn'] as bool,
      recipientCount: const IntegerConverter().fromJson(json['recipientCount']),
      attachmentCount: const IntegerConverter().fromJson(json['attachmentCount']),
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
      content: MessageContentDerivation.fromJson(json['content'] as Map<String, dynamic>),
      wasReadAt: json['wasReadAt'] as String?,
    );

Map<String, dynamic> _$MessageDVOToJson(MessageDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      'createdByDevice': instance.createdByDevice,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy.toJson(),
      'recipients': instance.recipients.map((e) => e.toJson()).toList(),
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
      'isOwn': instance.isOwn,
      if (const IntegerConverter().toJson(instance.recipientCount) case final value?) 'recipientCount': value,
      if (const IntegerConverter().toJson(instance.attachmentCount) case final value?) 'attachmentCount': value,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'statusText': instance.statusText,
      'peer': instance.peer.toJson(),
      'content': instance.content.toJson(),
      if (instance.wasReadAt case final value?) 'wasReadAt': value,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.Received: 'Received',
  MessageStatus.Delivering: 'Delivering',
  MessageStatus.Delivered: 'Delivered',
};

RecipientDVO _$RecipientDVOFromJson(Map<String, dynamic> json) => RecipientDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      publicKey: json['publicKey'] as String?,
      initials: json['initials'] as String,
      isSelf: json['isSelf'] as bool,
      hasRelationship: json['hasRelationship'] as bool,
      relationship: json['relationship'] == null ? null : RelationshipDVO.fromJson(json['relationship'] as Map<String, dynamic>),
      receivedAt: json['receivedAt'] as String?,
      receivedByDevice: json['receivedByDevice'] as String?,
    );

Map<String, dynamic> _$RecipientDVOToJson(RecipientDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.image case final value?) 'image': value,
      'type': instance.type,
      if (instance.date case final value?) 'date': value,
      if (instance.error?.toJson() case final value?) 'error': value,
      if (instance.warning?.toJson() case final value?) 'warning': value,
      if (instance.publicKey case final value?) 'publicKey': value,
      'initials': instance.initials,
      'isSelf': instance.isSelf,
      'hasRelationship': instance.hasRelationship,
      if (instance.relationship?.toJson() case final value?) 'relationship': value,
      if (instance.receivedAt case final value?) 'receivedAt': value,
      if (instance.receivedByDevice case final value?) 'receivedByDevice': value,
    };
