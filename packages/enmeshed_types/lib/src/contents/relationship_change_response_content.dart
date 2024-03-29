import 'dart:collection';

import 'arbitraty_json.dart';

abstract class RelationshipChangeResponseContent {
  const RelationshipChangeResponseContent();

  factory RelationshipChangeResponseContent.fromJson(Map json) => ArbitraryRelationshipChangeResponseContent(json);

  Map<String, dynamic> toJson();
}

class ArbitraryRelationshipChangeResponseContent extends RelationshipChangeResponseContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryRelationshipChangeResponseContent(Map internalJson) : internalJson = Map<String, dynamic>.from(internalJson);
}
