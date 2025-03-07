part of 'relationship_template_content_derivation.dart';

class RelationshipTemplateContent extends RelationshipTemplateContentDerivation {
  final String? title;
  final Map<String, dynamic>? metadata;
  final Request onNewRelationship;
  final Request? onExistingRelationship;

  const RelationshipTemplateContent({this.title, this.metadata, required this.onNewRelationship, this.onExistingRelationship});

  factory RelationshipTemplateContent.fromJson(Map json) => RelationshipTemplateContent(
    title: json['title'],
    metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
    onNewRelationship: Request.fromJson(json['onNewRelationship']),
    onExistingRelationship: json['onExistingRelationship'] != null ? Request.fromJson(json['onExistingRelationship']) : null,
  );

  @override
  Map<String, dynamic> toJson() => {
    '@type': 'RelationshipTemplateContent',
    if (title != null) 'title': title,
    if (metadata != null) 'metadata': metadata,
    'onNewRelationship': onNewRelationship.toJson(),
    if (onExistingRelationship != null) 'onExistingRelationship': onExistingRelationship?.toJson(),
  };

  @override
  List<Object?> get props => [title, metadata, onNewRelationship, onExistingRelationship];
}
