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
      recipientCount: json['recipientCount'] as int,
      attachmentCount: json['attachmentCount'] as int,
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
      content: json['content'] as Map<String, dynamic>,
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
  val['request'] = instance.request;
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
      recipientCount: json['recipientCount'] as int,
      attachmentCount: json['attachmentCount'] as int,
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
      content: json['content'] as Map<String, dynamic>,
      to: (json['to'] as List<dynamic>).map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>)).toList(),
      cc: (json['cc'] as List<dynamic>).map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>)).toList(),
      subject: json['subject'] as String,
      body: json['body'] as String,
      toCount: json['toCount'] as int,
      ccCount: json['ccCount'] as int,
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
  val['to'] = instance.to;
  val['cc'] = instance.cc;
  val['subject'] = instance.subject;
  val['body'] = instance.body;
  val['toCount'] = instance.toCount;
  val['ccCount'] = instance.ccCount;
  return val;
}
