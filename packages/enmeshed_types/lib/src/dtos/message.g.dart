// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDTO _$MessageDTOFromJson(Map<String, dynamic> json) => MessageDTO(
  id: json['id'] as String,
  isOwn: json['isOwn'] as bool,
  content: MessageContentDerivation.fromJson(json['content'] as Map<String, dynamic>),
  createdBy: json['createdBy'] as String,
  createdByDevice: json['createdByDevice'] as String,
  recipients: (json['recipients'] as List<dynamic>).map((e) => RecipientDTO.fromJson(e as Map<String, dynamic>)).toList(),
  createdAt: json['createdAt'] as String,
  attachments: (json['attachments'] as List<dynamic>).map((e) => e as String).toList(),
  wasReadAt: json['wasReadAt'] as String?,
);

Map<String, dynamic> _$MessageDTOToJson(MessageDTO instance) => <String, dynamic>{
  'id': instance.id,
  'isOwn': instance.isOwn,
  'content': instance.content.toJson(),
  'createdBy': instance.createdBy,
  'createdByDevice': instance.createdByDevice,
  'recipients': instance.recipients.map((e) => e.toJson()).toList(),
  'createdAt': instance.createdAt,
  'attachments': instance.attachments,
  if (instance.wasReadAt case final value?) 'wasReadAt': value,
};
