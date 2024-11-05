import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../consumption/local_request_dvo.dart';
import '../integer_converter.dart';
import '../transport/transport.dart';

part 'message_dvos.g.dart';

@JsonSerializable(includeIfNull: false)
class RequestMessageDVO extends MessageDVO {
  final LocalRequestDVO request;

  const RequestMessageDVO({
    required super.id,
    required super.name,
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
    required super.wasReadAt,
    required this.request,
  });

  factory RequestMessageDVO.fromJson(Map json) => _$RequestMessageDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RequestMessageDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RequestMessageErrorDVO extends MessageDVO {
  final String code;
  final String message;

  const RequestMessageErrorDVO({
    required super.id,
    required super.name,
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
    required super.wasReadAt,
    required this.code,
    required this.message,
  });

  factory RequestMessageErrorDVO.fromJson(Map json) => _$RequestMessageErrorDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RequestMessageErrorDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MailDVO extends MessageDVO {
  final List<RecipientDVO> to;
  final List<RecipientDVO> cc;
  final String subject;
  final String body;
  @IntegerConverter()
  final int toCount;
  @IntegerConverter()
  final int ccCount;

  const MailDVO({
    required super.id,
    required super.name,
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
    required super.wasReadAt,
    required this.to,
    required this.cc,
    required this.subject,
    required this.body,
    required this.toCount,
    required this.ccCount,
  });

  factory MailDVO.fromJson(Map json) => _$MailDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$MailDVOToJson(this);
}
