import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitraty_json.dart';
import '../response.dart';

part 'relationship_creation_content.dart';

abstract class RelationshipCreationContentDerivation extends Equatable {
  const RelationshipCreationContentDerivation();

  factory RelationshipCreationContentDerivation.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'RelationshipTemplateContent' => RelationshipCreationContent.fromJson(json),
      'ArbitraryRelationshipTemplateContent' => ArbitraryRelationshipCreationContent(json),
      _ => throw Exception('Unknown type: $type')
    };
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryRelationshipCreationContent extends RelationshipCreationContentDerivation with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryRelationshipCreationContent(Map internalJson) : internalJson = Map<String, dynamic>.from(internalJson);

  @override
  List<Object?> get props => [internalJson];
}
