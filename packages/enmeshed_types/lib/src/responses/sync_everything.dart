import 'package:equatable/equatable.dart';

import '../dtos/dtos.dart';

class SyncEverythingResponse extends Equatable {
  final List<RelationshipDTO> relationships;
  final List<MessageDTO> messages;
  final List<IdentityDeletionProcessDTO> identityDeletionProcesses;

  const SyncEverythingResponse({
    required this.relationships,
    required this.messages,
    required this.identityDeletionProcesses,
  });

  factory SyncEverythingResponse.fromJson(Map json) {
    return SyncEverythingResponse(
      relationships: List<RelationshipDTO>.from(json['relationships'].map((x) => RelationshipDTO.fromJson(x))),
      messages: List<MessageDTO>.from(json['messages'].map((x) => MessageDTO.fromJson(x))),
      identityDeletionProcesses: List<IdentityDeletionProcessDTO>.from(
        json['identityDeletionProcesses'].map((x) => IdentityDeletionProcessDTO.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relationships': relationships.map((e) => e.toJson()).toList(),
      'messages': messages.map((e) => e.toJson()).toList(),
      'identityDeletionProcesses': identityDeletionProcesses.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [relationships, messages, identityDeletionProcesses];
}
