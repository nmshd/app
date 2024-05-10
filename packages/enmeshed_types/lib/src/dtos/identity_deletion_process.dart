import 'package:equatable/equatable.dart';

enum IdentityDeletionProcessStatus { WaitingForApproval, Rejected, Approved, Deleting, Cancelled }

class IdentityDeletionProcessDTO extends Equatable {
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

  const IdentityDeletionProcessDTO(
      {required this.id,
      required this.status,
      this.createdAt,
      this.createdByDevice,
      this.rejectedAt,
      this.rejectedByDevice,
      this.approvedAt,
      this.approvedByDevice,
      this.gracePeriodEndsAt,
      this.cancelledAt,
      this.cancelledByDevice});

  factory IdentityDeletionProcessDTO.fromJson(Map json) {
    return IdentityDeletionProcessDTO(
      id: json['id'],
      status: IdentityDeletionProcessStatus.values.byName(json['status']),
      createdAt: json['createdAt'],
      createdByDevice: json['createdByDevice'],
      rejectedAt: json['rejectedAt'],
      rejectedByDevice: json['rejectedByDevice'],
      approvedAt: json['approvedAt'],
      approvedByDevice: json['approvedByDevice'],
      gracePeriodEndsAt: json['gracePeriodEndsAt'],
      cancelledAt: json['cancelledAt'],
      cancelledByDevice: json['cancelledByDevice'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status.name,
        'rejectedAt': rejectedAt,
        if (createdAt != null) 'createdAt': createdAt,
        if (createdByDevice != null) 'createdByDevice': createdByDevice,
        if (rejectedAt != null) 'rejectedAt': rejectedAt,
        if (rejectedByDevice != null) 'rejectedByDevice': rejectedByDevice,
        if (approvedAt != null) 'approvedAt': approvedAt,
        if (approvedByDevice != null) 'approvedByDevice': approvedByDevice,
        if (gracePeriodEndsAt != null) 'gracePeriodEndsAt': gracePeriodEndsAt,
        if (cancelledAt != null) 'cancelledAt': cancelledAt,
        if (cancelledByDevice != null) 'cancelledByDevice': cancelledByDevice,
      };

  @override
  List<Object?> get props => [
        id,
        status,
        createdAt,
        createdByDevice,
        rejectedAt,
        rejectedByDevice,
        approvedAt,
        approvedByDevice,
        gracePeriodEndsAt,
        cancelledAt,
        cancelledByDevice
      ];
}
