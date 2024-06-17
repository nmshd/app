import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitraty_json.dart';
import '../response.dart';

part 'relationship_creation_content_containing_response.dart';

abstract class RelationshipCreationContent extends Equatable {
  const RelationshipCreationContent();

  factory RelationshipCreationContent.fromJson(Map json) {
    if (json.containsKey('response')) {
      return RelationshipCreationContentContainingResponse.fromJson(json);
    }

    return ArbitraryRelationshipCreationContent(json);
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryRelationshipCreationContent extends RelationshipCreationContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryRelationshipCreationContent(Map internalJson) : internalJson = Map<String, dynamic>.from(internalJson);

  @override
  List<Object?> get props => [internalJson];
}
