import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../content/content.dart';
import '../transport/transport.dart';
import 'local_request_dvo.dart';

part 'peer_relationship_template_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class PeerRelationshipTemplateDVO extends RelationshipTemplateDVO {
  const PeerRelationshipTemplateDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.isOwn,
    required super.createdBy,
    required super.createdByDevice,
    required super.createdAt,
    super.expiresAt,
    super.maxNumberOfAllocations,
    super.onNewRelationship,
    super.onExistingRelationship,
    super.request,
    required super.content,
  }) : super(type: 'PeerRelationshipTemplateDVO');

  factory PeerRelationshipTemplateDVO.fromJson(Map json) => _$PeerRelationshipTemplateDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$PeerRelationshipTemplateDVOToJson(this);
}
