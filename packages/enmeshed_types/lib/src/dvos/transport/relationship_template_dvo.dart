import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../consumption/consumption.dart';
import '../content/content.dart';
import '../data_view_object.dart';
import 'identity_dvo.dart';

part 'relationship_template_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class RelationshipTemplateDVO extends DataViewObject {
  final bool isOwn;
  final IdentityDVO createdBy;
  final String createdByDevice;
  final String createdAt;
  final String? expiresAt;
  final int? maxNumberOfAllocations;
  final RequestDVO? onNewRelationship;
  final RequestDVO? onExistingRelationship;
  final LocalRequestDVO? request;
  final Map<String, dynamic> content;

  const RelationshipTemplateDVO({
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

  factory RelationshipTemplateDVO.fromJson(Map json) => switch (json['type']) {
        'PeerRelationshipTemplateDVO' => PeerRelationshipTemplateDVO.fromJson(json),
        _ => _$RelationshipTemplateDVOFromJson(Map<String, dynamic>.from(json)),
      };
  Map<String, dynamic> toJson() => _$RelationshipTemplateDVOToJson(this);
}
