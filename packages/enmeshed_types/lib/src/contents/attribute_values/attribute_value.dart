import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'identity/identity_attribute_value.dart';
import 'relationship/relationship_attribute_value.dart';

abstract class AttributeValue extends Equatable {
  const AttributeValue();

  factory AttributeValue.fromJson(Map json) {
    try {
      return IdentityAttributeValue.fromJson(json);
    } catch (_) {}

    try {
      return RelationshipAttributeValue.fromJson(json);
    } catch (_) {}

    final type = json['@type'];
    throw Exception('Unknown AttributeValue: $type');
  }

  @mustCallSuper
  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}
