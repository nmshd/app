// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_relationship_template_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicRelationshipTemplateReferenceDTO _$PublicRelationshipTemplateReferenceDTOFromJson(Map<String, dynamic> json) =>
    PublicRelationshipTemplateReferenceDTO(
      title: json['title'] as String,
      description: json['description'] as String,
      truncatedReference: json['truncatedReference'] as String,
    );

Map<String, dynamic> _$PublicRelationshipTemplateReferenceDTOToJson(PublicRelationshipTemplateReferenceDTO instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'truncatedReference': instance.truncatedReference,
};
