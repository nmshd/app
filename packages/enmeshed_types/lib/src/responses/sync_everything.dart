import 'package:equatable/equatable.dart';

import '../dtos/dtos.dart';

class SyncEverythingResponse extends Equatable {
  final List<RelationshipDTO> relationships;
  final List<MessageDTO> messages;

  const SyncEverythingResponse({
    required this.relationships,
    required this.messages,
  });

  factory SyncEverythingResponse.fromJson(Map json) {
    return SyncEverythingResponse(
      relationships: List<RelationshipDTO>.from(json['relationships'].map((x) => RelationshipDTO.fromJson(x))),
      messages: List<MessageDTO>.from(json['messages'].map((x) => MessageDTO.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relationships': relationships.map((e) => e.toJson()).toList(),
      'messages': messages.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() => 'SyncEverythingResponse(relationships: $relationships, messages: $messages)';

  @override
  List<Object?> get props => [relationships, messages];
}
