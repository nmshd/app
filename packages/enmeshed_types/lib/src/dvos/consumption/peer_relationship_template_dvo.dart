import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../content/content.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';
import 'local_request_dvo.dart';

part 'peer_relationship_template_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class PeerRelationshipTemplateDVO extends DataViewObject {
  bool isOwn;
  IdentityDVO createdBy;
  String createdByDevice;
  String createdAt;
  String? expiresAt;
  int? maxNumberOfAllocations;
  RequestDVO? onNewRelationship;
  RequestDVO? onExistingRelationship;
  LocalRequestDVO? request;
  Map<String, dynamic> content;

  PeerRelationshipTemplateDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.isOwn,
    required this.createdBy,
    required this.createdByDevice,
    required this.createdAt,
    this.expiresAt,
    this.maxNumberOfAllocations,
    this.onNewRelationship,
    this.onExistingRelationship,
    this.request,
    required this.content,
  });

  factory PeerRelationshipTemplateDVO.fromJson(Map json) => _$PeerRelationshipTemplateDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$PeerRelationshipTemplateDVOToJson(this);
}
