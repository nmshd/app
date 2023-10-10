import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../value_hints.dart';

part 'attribute_query.g.dart';
part 'identity_attribute_query.dart';
part 'iql_query.dart';
part 'iql_query_creation_hints.dart';
part 'relationship_attribute_creation_hints.dart';
part 'relationship_attribute_query.dart';
part 'third_party_relationship_attribute_query.dart';

abstract class AttributeQuery extends Equatable {
  const AttributeQuery();

  factory AttributeQuery.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'IdentityAttributeQuery' => IdentityAttributeQuery.fromJson(json),
      'ThirdPartyRelationshipAttributeQuery' => ThirdPartyRelationshipAttributeQuery.fromJson(json),
      'RelationshipAttributeQuery' => RelationshipAttributeQuery.fromJson(json),
      'IQLQuery' => IQLQuery.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props => [];
}
