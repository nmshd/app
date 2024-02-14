import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../contents/contents.dart';
import 'recipient.dart';

part 'message.g.dart';

@JsonSerializable()
class MessageDTO extends Equatable {
  final String id;
  final bool isOwn;
  final MessageContent content;
  final String createdBy;
  final String createdByDevice;
  final List<RecipientDTO> recipients;
  final String createdAt;
  final List<String> attachments;
  final String? wasReadAt;

  const MessageDTO({
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

  factory MessageDTO.fromJson(Map json) => _$MessageDTOFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$MessageDTOToJson(this);

  @override
  List<Object?> get props => [id, isOwn, content, createdBy, createdByDevice, recipients, createdAt, attachments, wasReadAt];
}
