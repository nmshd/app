import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../contents/contents.dart';
import 'object_reference.dart';

part 'relationship_template.g.dart';

@JsonSerializable(includeIfNull: false)
class RelationshipTemplateDTO extends Equatable {
  final String id;
  final bool isOwn;
  final String createdBy;
  final String createdByDevice;
  final String createdAt;
  final RelationshipTemplateContentDerivation content;
  final String? expiresAt;
  final int? maxNumberOfAllocations;
  final String? forIdentity;
  final PasswordProtection? passwordProtection;
  final ObjectReferenceDTO reference;

  const RelationshipTemplateDTO({
    required this.id,
    required this.isOwn,
    required this.createdBy,
    required this.createdByDevice,
    required this.createdAt,
    required this.content,
    this.expiresAt,
    this.maxNumberOfAllocations,
    this.forIdentity,
    this.passwordProtection,
    required this.reference,
  });

  factory RelationshipTemplateDTO.fromJson(Map json) => _$RelationshipTemplateDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$RelationshipTemplateDTOToJson(this);

  @override
  List<Object?> get props => [
    id,
    isOwn,
    createdBy,
    createdByDevice,
    createdAt,
    content,
    expiresAt,
    maxNumberOfAllocations,
    forIdentity,
    passwordProtection,
    reference,
  ];
}
