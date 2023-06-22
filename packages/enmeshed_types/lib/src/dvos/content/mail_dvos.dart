import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../consumption/local_request_dvo.dart';
import '../transport/transport.dart';

part 'mail_dvos.g.dart';

@JsonSerializable(includeIfNull: false)
class RequestMessageDVO extends MessageDVO {
  final LocalRequestDVO request;

  RequestMessageDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required super.createdByDevice,
    required super.createdAt,
    required super.createdBy,
    required super.recipients,
    required super.attachments,
    required super.isOwn,
    required super.recipientCount,
    required super.attachmentCount,
    required super.status,
    required super.statusText,
    required super.peer,
    required super.content,
    required this.request,
  });

  factory RequestMessageDVO.fromJson(Map<String, dynamic> json) => _$RequestMessageDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RequestMessageDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MailDVO extends MessageDVO {
  final List<RecipientDVO> to;
  final List<RecipientDVO> cc;
  final String subject;
  final String body;
  final int toCount;
  final int ccCount;

  MailDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required super.createdByDevice,
    required super.createdAt,
    required super.createdBy,
    required super.recipients,
    required super.attachments,
    required super.isOwn,
    required super.recipientCount,
    required super.attachmentCount,
    required super.status,
    required super.statusText,
    required super.peer,
    required super.content,
    required this.to,
    required this.cc,
    required this.subject,
    required this.body,
    required this.toCount,
    required this.ccCount,
  });

  factory MailDVO.fromJson(Map<String, dynamic> json) => _$MailDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MailDVOToJson(this);
}
