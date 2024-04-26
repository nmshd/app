import 'package:equatable/equatable.dart';

import '../contents/contents.dart';

class RelationshipChangeRequestDTO extends Equatable {
  final String createdBy;
  final String createdByDevice;
  final String createdAt;
  final RelationshipChangeRequestContent content;

  const RelationshipChangeRequestDTO({
    required this.createdBy,
    required this.createdByDevice,
    required this.createdAt,
    required this.content,
  });

  factory RelationshipChangeRequestDTO.fromJson(Map json) => RelationshipChangeRequestDTO(
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
  List<Object?> get props => [createdBy, createdByDevice, createdAt, content];
}
