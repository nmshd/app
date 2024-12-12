// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_with_attachments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageWithAttachmentsDTO _$MessageWithAttachmentsDTOFromJson(Map<String, dynamic> json) => MessageWithAttachmentsDTO(
      id: json['id'] as String,
      isOwn: json['isOwn'] as bool,
      content: MessageContentDerivation.fromJson(json['content'] as Map<String, dynamic>),
      createdBy: json['createdBy'] as String,
      createdByDevice: json['createdByDevice'] as String,
      recipients: (json['recipients'] as List<dynamic>).map((e) => RecipientDTO.fromJson(e as Map<String, dynamic>)).toList(),
      createdAt: json['createdAt'] as String,
      attachments: (json['attachments'] as List<dynamic>).map((e) => FileDTO.fromJson(e as Map<String, dynamic>)).toList(),
      wasReadAt: json['wasReadAt'] as String?,
    );

Map<String, dynamic> _$MessageWithAttachmentsDTOToJson(MessageWithAttachmentsDTO instance) => <String, dynamic>{
      'id': instance.id,
      'isOwn': instance.isOwn,
      'content': instance.content.toJson(),
      'createdBy': instance.createdBy,
      'createdByDevice': instance.createdByDevice,
      'recipients': instance.recipients.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
      if (instance.wasReadAt case final value?) 'wasReadAt': value,
    };
