import '../contents/contents.dart';
import 'file.dart';
import 'recipient.dart';

class MessageDTO {
  final String id;
  final bool isOwn;
  final MessageContent content;
  final String createdBy;
  final String createdByDevice;
  final List<RecipientDTO> recipients;
  final String createdAt;
  final List<String> attachments;

  MessageDTO({
    required this.id,
    required this.isOwn,
    required this.content,
    required this.createdBy,
    required this.createdByDevice,
    required this.recipients,
    required this.createdAt,
    required this.attachments,
  });

  factory MessageDTO.fromJson(Map<String, dynamic> json) => MessageDTO(
        id: json['id'],
        isOwn: json['isOwn'],
        content: MessageContent.fromJson(json['content']),
        createdBy: json['createdBy'],
        createdByDevice: json['createdByDevice'],
        recipients: List<RecipientDTO>.from(json['recipients'].map((x) => RecipientDTO.fromJson(x))),
        createdAt: json['createdAt'],
        attachments: List<String>.from(json['attachments']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isOwn': isOwn,
        'content': content.toJson(),
        'createdBy': createdBy,
        'createdByDevice': createdByDevice,
        'recipients': recipients.map((x) => x.toJson()).toList(),
        'createdAt': createdAt,
        'attachments': attachments,
      };

  @override
  String toString() {
    return 'MessageDTO { id: $id, isOwn: $isOwn, content: $content, createdBy: $createdBy, createdByDevice: $createdByDevice, recipients: $recipients, createdAt: $createdAt, attachments: $attachments }';
  }
}

class MessageWithAttachmentsDTO {
  final String id;
  final bool isOwn;
  final MessageContent content;
  final String createdBy;
  final String createdByDevice;
  final List<RecipientDTO> recipients;
  final String createdAt;
  final List<FileDTO> attachments;

  MessageWithAttachmentsDTO({
    required this.id,
    required this.isOwn,
    required this.content,
    required this.createdBy,
    required this.createdByDevice,
    required this.recipients,
    required this.createdAt,
    required this.attachments,
  });

  factory MessageWithAttachmentsDTO.fromJson(Map<String, dynamic> json) => MessageWithAttachmentsDTO(
        id: json['id'],
        isOwn: json['isOwn'],
        content: MessageContent.fromJson(json['content']),
        createdBy: json['createdBy'],
        createdByDevice: json['createdByDevice'],
        recipients: List<RecipientDTO>.from(json['recipients'].map((x) => RecipientDTO.fromJson(x))),
        createdAt: json['createdAt'],
        attachments: List<FileDTO>.from(json['attachments'].map((x) => FileDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isOwn': isOwn,
        'content': content.toJson(),
        'createdBy': createdBy,
        'createdByDevice': createdByDevice,
        'recipients': recipients.map((x) => x.toJson()).toList(),
        'createdAt': createdAt,
        'attachments': attachments.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'MessageWithAttachmentsDTO { id: $id, isOwn: $isOwn, content: $content, createdBy: $createdBy, createdByDevice: $createdByDevice, recipients: $recipients, createdAt: $createdAt, attachments: $attachments }';
  }
}
