import '../dtos/dtos.dart';

class SyncEverythingResponse {
  final List<RelationshipDTO> relationships;
  final List<MessageDTO> messages;

  SyncEverythingResponse({
    required this.relationships,
    required this.messages,
  });

  factory SyncEverythingResponse.fromJson(Map<String, dynamic> json) {
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
}
