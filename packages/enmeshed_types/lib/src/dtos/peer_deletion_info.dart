import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'peer_deletion_info.g.dart';

enum PeerDeletionStatus { ToBeDeleted, Deleted }

@JsonSerializable(includeIfNull: false)
class PeerDeletionInfo extends Equatable {
  final PeerDeletionStatus deletionStatus;
  final String deletionDate;

  const PeerDeletionInfo({
    required this.deletionStatus,
    required this.deletionDate,
  });

  factory PeerDeletionInfo.fromJson(Map json) => _$PeerDeletionInfoFromJson(Map<String, dynamic>.from(json));

  static PeerDeletionInfo? fromJsonNullable(Map? json) => json != null ? PeerDeletionInfo.fromJson(json) : null;

  Map<String, dynamic> toJson() => _$PeerDeletionInfoToJson(this);

  @override
  List<Object?> get props => [deletionStatus];
}
