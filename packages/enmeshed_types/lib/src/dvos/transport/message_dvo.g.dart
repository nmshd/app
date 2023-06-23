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
      recipientCount: json['recipientCount'] as int,
      attachmentCount: json['attachmentCount'] as int,
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
      content: json['content'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$MessageDVOToJson(MessageDVO instance) {
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
  val['createdByDevice'] = instance.createdByDevice;
  val['createdAt'] = instance.createdAt;
  val['createdBy'] = instance.createdBy;
  val['recipients'] = instance.recipients;
  val['attachments'] = instance.attachments;
  val['isOwn'] = instance.isOwn;
  val['recipientCount'] = instance.recipientCount;
  val['attachmentCount'] = instance.attachmentCount;
  val['status'] = _$MessageStatusEnumMap[instance.status]!;
  val['statusText'] = instance.statusText;
  val['peer'] = instance.peer;
  val['content'] = instance.content;
  return val;
}

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
      realm: json['realm'] as String,
      initials: json['initials'] as String,
      isSelf: json['isSelf'] as bool,
      hasRelationship: json['hasRelationship'] as bool,
      relationship: json['relationship'] == null ? null : RelationshipDVO.fromJson(json['relationship'] as Map<String, dynamic>),
      receivedAt: json['receivedAt'] as String?,
      receivedByDevice: json['receivedByDevice'] as String?,
    );

Map<String, dynamic> _$RecipientDVOToJson(RecipientDVO instance) {
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
  writeNotNull('publicKey', instance.publicKey);
  val['realm'] = instance.realm;
  val['initials'] = instance.initials;
  val['isSelf'] = instance.isSelf;
  val['hasRelationship'] = instance.hasRelationship;
  writeNotNull('relationship', instance.relationship);
  writeNotNull('receivedAt', instance.receivedAt);
  writeNotNull('receivedByDevice', instance.receivedByDevice);
  return val;
}
