import 'contents.dart';

class RelationshipTemplateContent extends AbstractRelationshipTemplateContent {
  final String? title;
  final Map<String, dynamic>? metadata;
  final Request onNewRelationship;
  final Request? onExistingRelationship;

  const RelationshipTemplateContent({
    this.title,
    this.metadata,
    required this.onNewRelationship,
    this.onExistingRelationship,
  });

  factory RelationshipTemplateContent.fromJson(Map<String, dynamic> json) => RelationshipTemplateContent(
        title: json['title'],
        metadata: json['metadata'],
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
