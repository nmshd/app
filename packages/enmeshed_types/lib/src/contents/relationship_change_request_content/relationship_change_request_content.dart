import 'dart:collection';

import '../arbitraty_json.dart';
import '../response.dart';

part 'relationship_creation_change_request_content.dart';

abstract class RelationshipChangeRequestContent {
  const RelationshipChangeRequestContent();

  factory RelationshipChangeRequestContent.fromJson(Map<String, dynamic> json) {
    final type = json['@type'];

    if (type == 'RelationshipCreationChangeRequestContent') {
      return RelationshipCreationChangeRequestContent.fromJson(json);
    }

    return ArbitraryRelationshipChangeRequestContent(json);
  }

  Map<String, dynamic> toJson();
}

class ArbitraryRelationshipChangeRequestContent extends RelationshipChangeRequestContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryRelationshipChangeRequestContent(this.internalJson);
}
