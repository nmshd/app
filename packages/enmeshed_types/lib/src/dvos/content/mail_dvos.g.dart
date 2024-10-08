// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMessageDVO _$RequestMessageDVOFromJson(Map<String, dynamic> json) => RequestMessageDVO(
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
      request: LocalRequestDVO.fromJson(json['request'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestMessageDVOToJson(RequestMessageDVO instance) {
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
  val['request'] = instance.request.toJson();
  return val;
}

const _$MessageStatusEnumMap = {
  MessageStatus.Received: 'Received',
  MessageStatus.Delivering: 'Delivering',
  MessageStatus.Delivered: 'Delivered',
};

MailDVO _$MailDVOFromJson(Map<String, dynamic> json) => MailDVO(
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
      to: (json['to'] as List<dynamic>).map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>)).toList(),
      cc: (json['cc'] as List<dynamic>).map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>)).toList(),
      subject: json['subject'] as String,
      body: json['body'] as String,
      toCount: const IntegerConverter().fromJson(json['toCount']),
      ccCount: const IntegerConverter().fromJson(json['ccCount']),
    );

Map<String, dynamic> _$MailDVOToJson(MailDVO instance) {
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
  val['to'] = instance.to.map((e) => e.toJson()).toList();
  val['cc'] = instance.cc.map((e) => e.toJson()).toList();
  val['subject'] = instance.subject;
  val['body'] = instance.body;
  writeNotNull('toCount', const IntegerConverter().toJson(instance.toCount));
  writeNotNull('ccCount', const IntegerConverter().toJson(instance.ccCount));
  return val;
}
