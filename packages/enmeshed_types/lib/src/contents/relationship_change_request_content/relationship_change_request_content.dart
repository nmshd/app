import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitraty_json.dart';
import '../response.dart';

part 'relationship_creation_change_request_content.dart';

abstract class RelationshipChangeRequestContent extends Equatable {
  const RelationshipChangeRequestContent();

  factory RelationshipChangeRequestContent.fromJson(Map<String, dynamic> json) {
    final type = json['@type'];

    if (type == 'RelationshipCreationChangeRequestContent') {
      return RelationshipCreationChangeRequestContent.fromJson(json);
    }

    return ArbitraryRelationshipChangeRequestContent(json);
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryRelationshipChangeRequestContent extends RelationshipChangeRequestContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryRelationshipChangeRequestContent(this.internalJson);

  @override
  List<Object?> get props => [internalJson];
}
