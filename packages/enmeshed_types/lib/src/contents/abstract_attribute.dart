import 'package:meta/meta.dart';

import 'identity_attribute.dart';
import 'relationship_attribute.dart';

abstract class AbstractAttribute {
  final String owner;
  final String? validFrom;
  final String? validTo;

  AbstractAttribute({
    required this.owner,
    this.validFrom,
    this.validTo,
  });

  static fromJson(Map<String, dynamic> json) {
    final type = json['@type'];

    if (type == 'IdentityAttribute') {
      return IdentityAttribute.fromJson(json);
    }

    if (type == 'RelationshipAttribute') {
      return RelationshipAttribute.fromJson(json);
    }

    throw Exception('Unknown AbstractAttribute: $type');
  }

  @mustCallSuper
  Map<String, dynamic> toJson() => {
        'owner': owner,
        if (validFrom != null) 'validFrom': validFrom,
        if (validTo != null) 'validTo': validTo,
      };
}
