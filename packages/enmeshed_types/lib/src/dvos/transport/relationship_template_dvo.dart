import 'package:json_annotation/json_annotation.dart';

import '../consumption/consumption.dart';
import '../content/content.dart';
import 'identity_dvo.dart';

part 'relationship_template_dvo.g.dart';

@JsonSerializable()
class RelationshipTemplateDVO {
  String type;
  bool isOwn;
  IdentityDVO createdBy;
  String createdByDevice;
  String createdAt;
  String? expiresAt;
  int? maxNumberOfAllocations;
  RequestDVO? onNewRelationship;
  RequestDVO? onExistingRelationship;
  LocalRequestDVO? request;
  dynamic content;

  RelationshipTemplateDVO({
    required this.type,
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

  factory RelationshipTemplateDVO.fromJson(Map<String, dynamic> json) => _$RelationshipTemplateDVOFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipTemplateDVOToJson(this);
}
