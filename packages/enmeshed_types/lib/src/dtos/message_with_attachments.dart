import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../contents/contents.dart';
import 'file.dart';
import 'recipient.dart';

part 'message_with_attachments.g.dart';

@JsonSerializable(includeIfNull: false)
class MessageWithAttachmentsDTO extends Equatable {
  final String id;
  final bool isOwn;
  final MessageContentDerivation content;
  final String createdBy;
  final String createdByDevice;
  final List<RecipientDTO> recipients;
  final String createdAt;
  final List<FileDTO> attachments;
  final String? wasReadAt;

  const MessageWithAttachmentsDTO({
    required this.id,
    required this.isOwn,
    required this.content,
    required this.createdBy,
    required this.createdByDevice,
    required this.recipients,
    required this.createdAt,
    required this.attachments,
    this.wasReadAt,
  });

  factory MessageWithAttachmentsDTO.fromJson(Map json) => _$MessageWithAttachmentsDTOFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$MessageWithAttachmentsDTOToJson(this);

  @override
  List<Object?> get props => [id, isOwn, content, createdBy, createdByDevice, recipients, createdAt, attachments, wasReadAt];
}
