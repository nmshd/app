import '../contents/contents.dart';

enum RelationshipChangeStatus { Pending, Rejected, Revoked, Accepted }

enum RelationshipChangeType { Creation, Termination, TerminationCancellation }

class RelationshipChangeRequestDTO {
  final String createdBy;
  final String createdByDevice;
  final String createdAt;
  final RelationshipChangeRequestContent content;

  RelationshipChangeRequestDTO({
    required this.createdBy,
    required this.createdByDevice,
    required this.createdAt,
    required this.content,
  });

  factory RelationshipChangeRequestDTO.fromJson(Map<String, dynamic> json) => RelationshipChangeRequestDTO(
        createdBy: json['createdBy'],
        createdByDevice: json['createdByDevice'],
        createdAt: json['createdAt'],
        content: RelationshipChangeRequestContent.fromJson(json['content']),
      );

  Map<String, dynamic> toJson() => {
        'createdBy': createdBy,
        'createdByDevice': createdByDevice,
        'createdAt': createdAt,
        'content': content.toJson(),
      };

  @override
  String toString() {
    return 'RelationshipChangeRequestDTO { createdBy: $createdBy, createdByDevice: $createdByDevice, createdAt: $createdAt, content: $content }';
  }
}

class RelationshipChangeResponseDTO {
  final String createdBy;
  final String createdByDevice;
  final String createdAt;
  final RelationshipChangeResponseContent content;

  RelationshipChangeResponseDTO({
    required this.createdBy,
    required this.createdByDevice,
    required this.createdAt,
    required this.content,
  });

  factory RelationshipChangeResponseDTO.fromJson(Map<String, dynamic> json) => RelationshipChangeResponseDTO(
        createdBy: json['createdBy'],
        createdByDevice: json['createdByDevice'],
        createdAt: json['createdAt'],
        content: RelationshipChangeResponseContent.fromJson(json['content']),
      );

  static RelationshipChangeResponseDTO? fromJsonNullable(Map<String, dynamic>? json) =>
      json != null ? RelationshipChangeResponseDTO.fromJson(json) : null;

  Map<String, dynamic> toJson() => {
        'createdBy': createdBy,
        'createdByDevice': createdByDevice,
        'createdAt': createdAt,
        'content': content.toJson(),
      };

  @override
  String toString() {
    return 'RelationshipChangeResponseDTO { createdBy: $createdBy, createdByDevice: $createdByDevice, createdAt: $createdAt, content: $content }';
  }
}

class RelationshipChangeDTO {
  final String id;
  final RelationshipChangeRequestDTO request;
  final RelationshipChangeStatus status;
  final RelationshipChangeType type;
  final RelationshipChangeResponseDTO? response;

  RelationshipChangeDTO({
    required this.id,
    required this.request,
    required this.status,
    required this.type,
    this.response,
  });

  factory RelationshipChangeDTO.fromJson(Map<String, dynamic> json) => RelationshipChangeDTO(
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
}
