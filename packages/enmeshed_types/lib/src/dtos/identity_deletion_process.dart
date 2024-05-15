import 'package:json_annotation/json_annotation.dart';

part 'identity_deletion_process.g.dart';

enum IdentityDeletionProcessStatus { WaitingForApproval, Rejected, Approved, Deleting, Cancelled }

@JsonSerializable(includeIfNull: false)
class IdentityDeletionProcessDTO {
  final String id;
  final IdentityDeletionProcessStatus status;
  final String? createdAt;
  final String? createdByDevice;
  final String? rejectedAt;
  final String? rejectedByDevice;
  final String? approvedAt;
  final String? approvedByDevice;
  final String? gracePeriodEndsAt;
  final String? cancelledAt;
  final String? cancelledByDevice;

  const IdentityDeletionProcessDTO({
    required this.id,
    required this.status,
    this.createdAt,
    this.createdByDevice,
    this.rejectedAt,
    this.rejectedByDevice,
    this.approvedAt,
    this.approvedByDevice,
    this.gracePeriodEndsAt,
    this.cancelledAt,
    this.cancelledByDevice,
  });

  factory IdentityDeletionProcessDTO.fromJson(Map json) => _$IdentityDeletionProcessDTOFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$IdentityDeletionProcessDTOToJson(this);
}
