import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_attribute_deletion_info.g.dart';

enum LocalAttributeDeletionStatus { DeletionRequestSent, DeletionRequestRejected, ToBeDeleted, ToBeDeletedByPeer, DeletedByPeer, DeletedByOwner }

@JsonSerializable(includeIfNull: false)
class LocalAttributeDeletionInfo extends Equatable {
  final LocalAttributeDeletionStatus deletionStatus;
  final String deletionDate;

  const LocalAttributeDeletionInfo({
    required this.deletionStatus,
    required this.deletionDate,
  });

  factory LocalAttributeDeletionInfo.fromJson(Map json) => _$LocalAttributeDeletionInfoFromJson(Map<String, dynamic>.from(json));

  static LocalAttributeDeletionInfo? fromJsonNullable(Map? json) => json != null ? LocalAttributeDeletionInfo.fromJson(json) : null;

  Map<String, dynamic> toJson() => _$LocalAttributeDeletionInfoToJson(this);

  @override
  List<Object?> get props => [deletionStatus, deletionDate];
}
