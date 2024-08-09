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
      content: MessageContent.fromJson(json['content'] as Map<String, dynamic>),
      wasReadAt: json['wasReadAt'] as String?,
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  val['createdByDevice'] = instance.createdByDevice;
  val['createdAt'] = instance.createdAt;
  val['createdBy'] = instance.createdBy.toJson();
  val['recipients'] = instance.recipients.map((e) => e.toJson()).toList();
  val['attachments'] = instance.attachments.map((e) => e.toJson()).toList();
  val['isOwn'] = instance.isOwn;
  writeNotNull('recipientCount', const IntegerConverter().toJson(instance.recipientCount));
  writeNotNull('attachmentCount', const IntegerConverter().toJson(instance.attachmentCount));
  val['status'] = _$MessageStatusEnumMap[instance.status]!;
  val['statusText'] = instance.statusText;
  val['peer'] = instance.peer.toJson();
  val['content'] = instance.content.toJson();
  writeNotNull('wasReadAt', instance.wasReadAt);
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
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  writeNotNull('publicKey', instance.publicKey);
  val['initials'] = instance.initials;
  val['isSelf'] = instance.isSelf;
  val['hasRelationship'] = instance.hasRelationship;
  writeNotNull('relationship', instance.relationship?.toJson());
  writeNotNull('receivedAt', instance.receivedAt);
  writeNotNull('receivedByDevice', instance.receivedByDevice);
  return val;
}
