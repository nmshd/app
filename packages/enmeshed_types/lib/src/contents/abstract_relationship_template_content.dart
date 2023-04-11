import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'contents.dart';

abstract class AbstractRelationshipTemplateContent extends Equatable {
  const AbstractRelationshipTemplateContent();

  factory AbstractRelationshipTemplateContent.fromJson(Map<String, dynamic> json) {
    final type = json['@type'];
    if (type == 'RelationshipTemplateContent') {
      return RelationshipTemplateContent.fromJson(json);
    }

    return ArbitraryRelationshipTemplateContent(json);
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryRelationshipTemplateContent extends AbstractRelationshipTemplateContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryRelationshipTemplateContent(this.internalJson);

  @override
  List<Object?> get props => [internalJson];
}
