import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitraty_json.dart';
import '../contents.dart';

part 'relationship_template_content.dart';

abstract class RelationshipTemplateContentDerivation extends Equatable {
  const RelationshipTemplateContentDerivation();

  factory RelationshipTemplateContentDerivation.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'RelationshipTemplateContent' => RelationshipTemplateContent.fromJson(json),
      'ArbitraryRelationshipTemplateContent' => ArbitraryRelationshipTemplateContent(json),
      _ => throw Exception('Unknown type: $type')
    };
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryRelationshipTemplateContent extends RelationshipTemplateContentDerivation with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryRelationshipTemplateContent(Map internalJson) : internalJson = Map<String, dynamic>.from(internalJson);

  @override
  List<Object?> get props => [internalJson];
}
