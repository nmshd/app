import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'relationship_status.dart';

part 'relationship_audit_log_entry.g.dart';

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

@JsonSerializable(includeIfNull: false)
class RelationshipAuditLogEntryDTO extends Equatable {
  final String createdAt;
  final String createdBy;
  final String createdByDevice;
  final RelationshipAuditLogEntryReason reason;
  final RelationshipStatus? oldStatus;
  final RelationshipStatus newStatus;

  const RelationshipAuditLogEntryDTO({
    required this.createdAt,
    required this.createdBy,
    required this.createdByDevice,
    required this.reason,
    this.oldStatus,
    required this.newStatus,
  });

  factory RelationshipAuditLogEntryDTO.fromJson(Map json) => _$RelationshipAuditLogEntryDTOFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$RelationshipAuditLogEntryDTOToJson(this);

  @override
  List<Object?> get props => [createdAt, createdBy, createdByDevice, reason, oldStatus, newStatus];
}
