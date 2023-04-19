import 'package:equatable/equatable.dart';

import '../contents/contents.dart';
import 'recipient.dart';

class MessageDTO extends Equatable {
  final String id;
  final bool isOwn;
  final MessageContent content;
  final String createdBy;
  final String createdByDevice;
  final List<RecipientDTO> recipients;
  final String createdAt;
  final List<String> attachments;

  const MessageDTO({
    required this.id,
    required this.isOwn,
    required this.content,
    required this.createdBy,
    required this.createdByDevice,
    required this.recipients,
    required this.createdAt,
    required this.attachments,
  });

  factory MessageDTO.fromJson(Map json) => MessageDTO(
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

  @override
  List<Object?> get props => [id, isOwn, content, createdBy, createdByDevice, recipients, createdAt, attachments];
}
