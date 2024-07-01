import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../content/mail_dvos.dart';
import '../data_view_object.dart';
import '../integer_converter.dart';
import 'file_dvo.dart';
import 'identity_dvo.dart';
import 'relationship_dvo.dart';

part 'message_dvo.g.dart';

enum MessageStatus { Received, Delivering, Delivered }

@JsonSerializable(includeIfNull: false)
class MessageDVO extends DataViewObject {
  final String createdByDevice;
  final String createdAt;
  final IdentityDVO createdBy;
  final List<RecipientDVO> recipients;
  final List<FileDVO> attachments;
  final bool isOwn;
  @IntegerConverter()
  final int recipientCount;
  @IntegerConverter()
  final int attachmentCount;
  final MessageStatus status;
  final String statusText;
  final IdentityDVO peer;
  final MessageContent content;
  final String? wasReadAt;

  const MessageDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.createdByDevice,
    required this.createdAt,
    required this.createdBy,
    required this.recipients,
    required this.attachments,
    required this.isOwn,
    required this.recipientCount,
    required this.attachmentCount,
    required this.status,
    required this.statusText,
    required this.peer,
    required this.content,
    this.wasReadAt,
  });

  factory MessageDVO.fromJson(Map json) => switch (json['type']) {
        'MessageDVO' => _$MessageDVOFromJson(Map<String, dynamic>.from(json)),
        'RequestMessageDVO' => RequestMessageDVO.fromJson(json),
        'MailDVO' => MailDVO.fromJson(json),
        _ => throw Exception('Unknown type: ${json['type']}'),
      };
  Map<String, dynamic> toJson() => _$MessageDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RecipientDVO extends IdentityDVO {
  final String? receivedAt;
  final String? receivedByDevice;

  const RecipientDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    super.publicKey,
    required super.initials,
    required super.isSelf,
    required super.hasRelationship,
    super.relationship,
    this.receivedAt,
    this.receivedByDevice,
  });

  factory RecipientDVO.fromJson(Map json) => _$RecipientDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RecipientDVOToJson(this);
}
