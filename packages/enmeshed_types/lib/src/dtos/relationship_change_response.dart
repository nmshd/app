import 'package:equatable/equatable.dart';

import '../contents/contents.dart';

class RelationshipChangeResponseDTO extends Equatable {
  final String createdBy;
  final String createdByDevice;
  final String createdAt;
  final RelationshipChangeResponseContent content;

  const RelationshipChangeResponseDTO({
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

  @override
  List<Object?> get props => [createdBy, createdByDevice, createdAt, content];
}
