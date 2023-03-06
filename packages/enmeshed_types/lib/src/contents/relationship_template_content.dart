import 'dart:collection';

import 'arbitraty_json.dart';
import 'contents.dart';

abstract class AbstractRelationshipTemplateContent {
  const AbstractRelationshipTemplateContent();

  factory AbstractRelationshipTemplateContent.fromJson(Map<String, dynamic> json) {
    final type = json['@type'];
    if (type == 'RelationshipTemplateContent') {
      return RelationshipTemplateContent.fromJson(json);
    }

    return ArbitraryRelationshipTemplateContent(json);
  }

  Map<String, dynamic> toJson();
}

class ArbitraryRelationshipTemplateContent extends AbstractRelationshipTemplateContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryRelationshipTemplateContent(this.internalJson);
}

class RelationshipTemplateContent extends AbstractRelationshipTemplateContent {
  final String? title;
  final Map<String, dynamic>? metadata;
  final Request onNewRelationship;
  final Request? onExistingRelationship;

  RelationshipTemplateContent({
    this.title,
    this.metadata,
    required this.onNewRelationship,
    required this.onExistingRelationship,
  });

  factory RelationshipTemplateContent.fromJson(Map<String, dynamic> json) => RelationshipTemplateContent(
        title: json['title'],
        metadata: json['metadata'],
        onNewRelationship: Request.fromJson(json['onNewRelationship']),
        onExistingRelationship: json['onExistingRelationship'] != null ? Request.fromJson(json['onExistingRelationship']) : null,
      );

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'metadata': metadata,
        'onNewRelationship': onNewRelationship.toJson(),
        if (onExistingRelationship != null) 'onExistingRelationship': onExistingRelationship?.toJson(),
      };
}
