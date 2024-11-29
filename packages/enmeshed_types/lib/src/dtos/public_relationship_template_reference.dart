import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_relationship_template_reference.g.dart';

@JsonSerializable(includeIfNull: false)
class PublicRelationshipTemplateReferenceDTO extends Equatable {
  final String title;
  final String description;
  final String truncatedReference;

  const PublicRelationshipTemplateReferenceDTO({
    required this.title,
    required this.description,
    required this.truncatedReference,
  });

  factory PublicRelationshipTemplateReferenceDTO.fromJson(Map json) {
    return _$PublicRelationshipTemplateReferenceDTOFromJson(Map<String, dynamic>.from(json));
  }
  Map<String, dynamic> toJson() => _$PublicRelationshipTemplateReferenceDTOToJson(this);

  @override
  List<Object?> get props => [title, description, truncatedReference];
}
