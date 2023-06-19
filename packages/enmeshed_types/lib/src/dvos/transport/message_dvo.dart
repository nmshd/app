import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';
import 'file_dvo.dart';
import 'identity_dvo.dart';
import 'relationship_dvo.dart';

part 'message_dvo.g.dart';

enum MessageStatus { Received, Delivering, Delivered }

@JsonSerializable()
class MessageDVO extends DataViewObject {
  String createdByDevice;
  String createdAt;
  IdentityDVO createdBy;
  List<RecipientDVO> recipients;
  List<FileDVO> attachments;
  bool isOwn;
  int recipientCount;
  int attachmentCount;
  MessageStatus status;
  String statusText;
  IdentityDVO peer;
  Map<String, dynamic> content;

  MessageDVO({
    required super.id,
    super.name,
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
  });

  factory MessageDVO.fromJson(Map<String, dynamic> json) => _$MessageDVOFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDVOToJson(this);
}

@JsonSerializable()
class RecipientDVO extends IdentityDVO {
  String? receivedAt;
  String? receivedByDevice;

  RecipientDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    super.publicKey,
    required super.realm,
    required super.initials,
    required super.isSelf,
    required super.hasRelationship,
    super.relationship,
    this.receivedAt,
    this.receivedByDevice,
  });

  factory RecipientDVO.fromJson(Map<String, dynamic> json) => _$RecipientDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RecipientDVOToJson(this);
}
