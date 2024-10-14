import 'package:equatable/equatable.dart';

import '../contents/contents.dart';

class RelationshipTemplateDTO extends Equatable {
  final String id;
  final bool isOwn;
  final String createdBy;
  final String createdByDevice;
  final String createdAt;
  final RelationshipTemplateContentDerivation content;
  final String? expiresAt;
  final int? maxNumberOfAllocations;
  final String truncatedReference;
  final String? forIdentity;

  const RelationshipTemplateDTO({
    required this.id,
    required this.isOwn,
    required this.createdBy,
    required this.createdByDevice,
    required this.createdAt,
    required this.content,
    this.expiresAt,
    this.maxNumberOfAllocations,
    required this.truncatedReference,
    this.forIdentity,
  });

  factory RelationshipTemplateDTO.fromJson(Map json) => RelationshipTemplateDTO(
        id: json['id'],
        isOwn: json['isOwn'],
        createdBy: json['createdBy'],
        createdByDevice: json['createdByDevice'],
        createdAt: json['createdAt'],
        content: RelationshipTemplateContentDerivation.fromJson(json['content']),
        expiresAt: json['expiresAt'],
        maxNumberOfAllocations: json['maxNumberOfAllocations']?.toInt(),
        truncatedReference: json['truncatedReference'],
        forIdentity: json['forIdentity'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isOwn': isOwn,
        'createdBy': createdBy,
        'createdByDevice': createdByDevice,
        'createdAt': createdAt,
        'content': content.toJson(),
        if (expiresAt != null) 'expiresAt': expiresAt,
        if (maxNumberOfAllocations != null) 'maxNumberOfAllocations': maxNumberOfAllocations,
        'truncatedReference': truncatedReference,
        if (forIdentity != null) 'forIdentity': forIdentity,
      };

  @override
  List<Object?> get props => [
        id,
        isOwn,
        createdBy,
        createdByDevice,
        createdAt,
        content,
        expiresAt,
        maxNumberOfAllocations,
        truncatedReference,
        forIdentity,
      ];
}
