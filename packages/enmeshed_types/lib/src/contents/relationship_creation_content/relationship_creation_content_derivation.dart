import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitrary_content_json.dart';
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

class ArbitraryRelationshipCreationContent extends RelationshipCreationContentDerivation with MapMixin<String, dynamic>, ArbitraryContentJSON {
  @override
  final Map<String, dynamic> value;

  ArbitraryRelationshipCreationContent(Map internalJson) : value = Map<String, dynamic>.from(internalJson);

  factory ArbitraryRelationshipCreationContent.fromJson(Map json) => ArbitraryRelationshipCreationContent(json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': 'ArbitraryRelationshipCreationContent', 'value': value};

  @override
  List<Object?> get props => [value];
}
