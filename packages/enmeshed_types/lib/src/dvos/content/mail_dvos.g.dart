// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMessageDVO _$RequestMessageDVOFromJson(Map<String, dynamic> json) =>
    RequestMessageDVO(
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
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      createdBy:
          IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => FileDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      isOwn: json['isOwn'] as bool,
      recipientCount: json['recipientCount'] as int,
      attachmentCount: json['attachmentCount'] as int,
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
      content: json['content'] as Map<String, dynamic>,
      request:
          LocalRequestDVO.fromJson(json['request'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestMessageDVOToJson(RequestMessageDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'createdByDevice': instance.createdByDevice,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'recipients': instance.recipients,
      'attachments': instance.attachments,
      'isOwn': instance.isOwn,
      'recipientCount': instance.recipientCount,
      'attachmentCount': instance.attachmentCount,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'statusText': instance.statusText,
      'peer': instance.peer,
      'content': instance.content,
      'request': instance.request,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.Received: 'Received',
  MessageStatus.Delivering: 'Delivering',
  MessageStatus.Delivered: 'Delivered',
};

MailDVO _$MailDVOFromJson(Map<String, dynamic> json) => MailDVO(
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
      createdByDevice: json['createdByDevice'] as String,
      createdAt: json['createdAt'] as String,
      createdBy:
          IdentityDVO.fromJson(json['createdBy'] as Map<String, dynamic>),
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => FileDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      isOwn: json['isOwn'] as bool,
      recipientCount: json['recipientCount'] as int,
      attachmentCount: json['attachmentCount'] as int,
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      statusText: json['statusText'] as String,
      peer: IdentityDVO.fromJson(json['peer'] as Map<String, dynamic>),
      content: json['content'] as Map<String, dynamic>,
      to: (json['to'] as List<dynamic>)
          .map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      cc: (json['cc'] as List<dynamic>)
          .map((e) => RecipientDVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      subject: json['subject'] as String,
      body: json['body'] as String,
      toCount: json['toCount'] as int,
      ccCount: json['ccCount'] as int,
    );

Map<String, dynamic> _$MailDVOToJson(MailDVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
      'createdByDevice': instance.createdByDevice,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'recipients': instance.recipients,
      'attachments': instance.attachments,
      'isOwn': instance.isOwn,
      'recipientCount': instance.recipientCount,
      'attachmentCount': instance.attachmentCount,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'statusText': instance.statusText,
      'peer': instance.peer,
      'content': instance.content,
      'to': instance.to,
      'cc': instance.cc,
      'subject': instance.subject,
      'body': instance.body,
      'toCount': instance.toCount,
      'ccCount': instance.ccCount,
    };
