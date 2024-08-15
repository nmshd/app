import 'package:equatable/equatable.dart';

import '../contents/contents.dart';
import 'identity.dart';
import 'peer_deletion_info.dart';
import 'relationship_template.dart';

enum RelationshipStatus { Pending, Active, Rejected, Revoked, Terminated, DeletionProposed }

enum RelationshipAuditLogEntryReason {
  Creation,
  AcceptanceOfCreation,
  RejectionOfCreation,
  RevocationOfCreation,
  Termination,
  ReactivationRequested,
  AcceptanceOfReactivation,
  RejectionOfReactivation,
  RevocationOfReactivation,
  Decomposition
}

class RelationshipDTO extends Equatable {
  final String id;
  final RelationshipTemplateDTO template;
  final RelationshipStatus status;
  final String peer;
  final IdentityDTO peerIdentity;
  final PeerDeletionInfo? peerDeletionInfo;
  final RelationshipCreationContentDerivation creationContent;
  final List<RelationshipAuditLogEntryDTO> auditLog;

  const RelationshipDTO({
    required this.id,
    required this.template,
    required this.status,
    required this.peer,
    required this.peerIdentity,
    this.peerDeletionInfo,
    required this.creationContent,
    required this.auditLog,
  });

  factory RelationshipDTO.fromJson(Map json) => RelationshipDTO(
        id: json['id'],
        template: RelationshipTemplateDTO.fromJson(json['template']),
        status: RelationshipStatus.values.byName(json['status']),
        peer: json['peer'],
        peerIdentity: IdentityDTO.fromJson(json['peerIdentity']),
        peerDeletionInfo: PeerDeletionInfo.fromJsonNullable(json['peerDeletionInfo']),
        creationContent: RelationshipCreationContentDerivation.fromJson(json['creationContent']),
        auditLog: List<RelationshipAuditLogEntryDTO>.from(json['auditLog'].map((x) => RelationshipAuditLogEntryDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'template': template.toJson(),
        'status': status.name,
        'peer': peer,
        'peerIdentity': peerIdentity.toJson(),
        if (peerDeletionInfo != null) 'peerDeletionInfo': peerDeletionInfo?.toJson(),
        'creationContent': creationContent.toJson(),
        'auditLog': auditLog.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [id, template, status, peer, peerIdentity, creationContent, auditLog];
}

class RelationshipAuditLogEntryDTO extends Equatable {
  final String createdAt;
  final String createdBy;
  final String createdByDevice;
  final RelationshipAuditLogEntryReason reason;
  final RelationshipStatus? oldStatus;
  final RelationshipStatus newStatus;

  const RelationshipAuditLogEntryDTO(
      {required this.createdAt,
      required this.createdBy,
      required this.createdByDevice,
      required this.reason,
      this.oldStatus,
      required this.newStatus});

  factory RelationshipAuditLogEntryDTO.fromJson(Map json) => RelationshipAuditLogEntryDTO(
        createdAt: json['createdAt'],
        createdBy: json['createdBy'],
        createdByDevice: json['createdByDevice'],
        reason: RelationshipAuditLogEntryReason.values.byName(json['reason']),
        oldStatus: json['oldStatus'] == null ? null : RelationshipStatus.values.byName(json['oldStatus']),
        newStatus: RelationshipStatus.values.byName(json['newStatus']),
      );

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'createdAt': createdAt,
      'createdBy': createdBy,
      'createdByDevice': createdByDevice,
      'reason': reason.name,
      'oldStatus': oldStatus?.name,
      'newStatus': newStatus.name,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }

  @override
  List<Object?> get props => [createdAt, createdBy, createdByDevice, reason, oldStatus, newStatus];
}
