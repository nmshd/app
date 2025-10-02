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
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  createdByDevice: json['createdByDevice'] as String,
  createdAt: json['createdAt'] as String,
  createdBy: IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
  recipients: (json['recipients'] as List<dynamic>)
      .map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>))
      .toList(),
  attachments: (json['attachments'] as List<dynamic>)
      .map((e) => FileDVO.fromJson(e as Map<String, dynamic>))
      .toList(),
  isOwn: json['isOwn'] as bool,
  recipientCount: const IntegerConverter().fromJson(
    json['recipientCount'] as Object,
  ),
  attachmentCount: const IntegerConverter().fromJson(
    json['attachmentCount'] as Object,
  ),
  status: $enumDecode(_$MessageStatusEnumMap, json['status']),
  statusText: json['statusText'] as String,
  peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
  content: MessageContentDerivation.fromJson(
    json['content'] as Map<String, dynamic>,
  ),
  wasReadAt: json['wasReadAt'] as String?,
);

Map<String, dynamic> _$MessageDVOToJson(
  MessageDVO instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': ?instance.description,
  'image': ?instance.image,
  'type': instance.type,
  'date': ?instance.date,
  'error': ?instance.error?.toJson(),
  'warning': ?instance.warning?.toJson(),
  'createdByDevice': instance.createdByDevice,
  'createdAt': instance.createdAt,
  'createdBy': instance.createdBy.toJson(),
  'recipients': instance.recipients.map((e) => e.toJson()).toList(),
  'attachments': instance.attachments.map((e) => e.toJson()).toList(),
  'isOwn': instance.isOwn,
  'recipientCount': const IntegerConverter().toJson(instance.recipientCount),
  'attachmentCount': const IntegerConverter().toJson(instance.attachmentCount),
  'status': _$MessageStatusEnumMap[instance.status]!,
  'statusText': instance.statusText,
  'peer': instance.peer.toJson(),
  'content': instance.content.toJson(),
  'wasReadAt': ?instance.wasReadAt,
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
  error: json['error'] == null
      ? null
      : DVOError.fromJson(json['error'] as Map<String, dynamic>),
  warning: json['warning'] == null
      ? null
      : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
  publicKey: json['publicKey'] as String?,
  initials: json['initials'] as String,
  isSelf: json['isSelf'] as bool,
  hasRelationship: json['hasRelationship'] as bool,
  relationship: json['relationship'] == null
      ? null
      : RelationshipDVO.fromJson(json['relationship'] as Map<String, dynamic>),
  receivedAt: json['receivedAt'] as String?,
  receivedByDevice: json['receivedByDevice'] as String?,
);

Map<String, dynamic> _$RecipientDVOToJson(RecipientDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': ?instance.description,
      'image': ?instance.image,
      'type': instance.type,
      'date': ?instance.date,
      'error': ?instance.error?.toJson(),
      'warning': ?instance.warning?.toJson(),
      'publicKey': ?instance.publicKey,
      'initials': instance.initials,
      'isSelf': instance.isSelf,
      'hasRelationship': instance.hasRelationship,
      'relationship': ?instance.relationship?.toJson(),
      'receivedAt': ?instance.receivedAt,
      'receivedByDevice': ?instance.receivedByDevice,
    };
