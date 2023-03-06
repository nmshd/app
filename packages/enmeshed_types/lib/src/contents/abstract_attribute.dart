import 'package:meta/meta.dart';

part 'identitiy_attribute.dart';
part 'relationship_attribute.dart';

abstract class AbstractAttribute {
  final String owner;
  final String? validFrom;
  final String? validTo;
  final Map<String, dynamic> value;

  AbstractAttribute({
    required this.owner,
    this.validFrom,
    this.validTo,
    required this.value,
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
        'value': value,
      };
}
