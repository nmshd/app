import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../dtos/dtos.dart';

part 'sync_everything.g.dart';

@JsonSerializable(includeIfNull: false)
class SyncEverythingResponse extends Equatable {
  final List<RelationshipDTO> relationships;
  final List<MessageDTO> messages;
  final List<IdentityDeletionProcessDTO> identityDeletionProcesses;

  const SyncEverythingResponse({
    required this.relationships,
    required this.messages,
    required this.identityDeletionProcesses,
  });

  factory SyncEverythingResponse.fromJson(Map<String, dynamic> json) => _$SyncEverythingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SyncEverythingResponseToJson(this);

  @override
  List<Object?> get props => [relationships, messages, identityDeletionProcesses];
}
