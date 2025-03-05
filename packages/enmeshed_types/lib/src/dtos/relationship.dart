import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../contents/contents.dart';
import 'identity.dart';
import 'peer_deletion_info.dart';
import 'relationship_audit_log_entry.dart';
import 'relationship_status.dart';
import 'relationship_template.dart';

part 'relationship.g.dart';

@JsonSerializable(includeIfNull: false)
class RelationshipDTO extends Equatable {
  final String id;
  final String templateId;
  final RelationshipStatus status;
  final String peer;
  final IdentityDTO peerIdentity;
  final PeerDeletionInfo? peerDeletionInfo;
  final RelationshipCreationContentDerivation creationContent;
  final List<RelationshipAuditLogEntryDTO> auditLog;

  const RelationshipDTO({
    required this.id,
    required this.templateId,
    required this.status,
    required this.peer,
    required this.peerIdentity,
    this.peerDeletionInfo,
    required this.creationContent,
    required this.auditLog,
  });

  factory RelationshipDTO.fromJson(Map json) => _$RelationshipDTOFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$RelationshipDTOToJson(this);

  @override
  List<Object?> get props => [id, templateId, status, peer, peerIdentity, peerDeletionInfo, creationContent, auditLog];
}
