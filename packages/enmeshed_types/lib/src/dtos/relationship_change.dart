import 'package:equatable/equatable.dart';

import 'dtos.dart';

enum RelationshipChangeStatus { Pending, Rejected, Revoked, Accepted }

enum RelationshipChangeType { Creation, Termination, TerminationCancellation }

class RelationshipChangeDTO extends Equatable {
  final String id;
  final RelationshipChangeRequestDTO request;
  final RelationshipChangeStatus status;
  final RelationshipChangeType type;
  final RelationshipChangeResponseDTO? response;

  const RelationshipChangeDTO({
    required this.id,
    required this.request,
    required this.status,
    required this.type,
    this.response,
  });

  factory RelationshipChangeDTO.fromJson(Map json) => RelationshipChangeDTO(
        id: json['id'],
        request: RelationshipChangeRequestDTO.fromJson(json['request']),
        status: RelationshipChangeStatus.values.byName(json['status']),
        type: RelationshipChangeType.values.byName(json['type']),
        response: RelationshipChangeResponseDTO.fromJsonNullable(json['response']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'request': request.toJson(),
        'status': status.name,
        'type': type.name,
        if (response != null) 'response': response?.toJson(),
      };

  @override
  String toString() {
    return 'RelationshipChange { id: $id, request: $request, status: $status, type: $type, response: $response }';
  }

  @override
  List<Object?> get props => [id, request, status, type, response];
}
