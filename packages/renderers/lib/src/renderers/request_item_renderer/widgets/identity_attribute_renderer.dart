import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/complex_attribute_list_tile.dart';
import '../../widgets/custom_list_tile.dart';
import 'relationship_attribute_renderer.dart';

class DraftIdentityAttributeRenderer extends StatelessWidget {
  final DraftIdentityAttributeDVO attribute;

  const DraftIdentityAttributeRenderer({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.content) {
      final IdentityAttribute attribute => IdentityAttributeRenderer(attribute: attribute),
      final RelationshipAttribute attribute => RelationshipAttributeRenderer(attribute: attribute),
      _ => throw Exception('Unknown AbstractAttribute: ${attribute.content.runtimeType}')
    };
  }
}

class IdentityAttributeRenderer extends StatelessWidget {
  final IdentityAttribute attribute;

  const IdentityAttributeRenderer({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = attribute.value.toJson();

    if (attributeValueMap.length == 2) {
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${attribute.value.atType}',
        value: attributeValueMap['value'].toString(),
      );
    }

    final List<({String label, String value})> fields = attributeValueMap.entries
        .where((e) => e.key != '@type')
        .map((e) => (label: 'i18n://attributes.values.${attribute.value.atType}.${e.key}.label', value: e.value.toString()))
        .toList();

    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.${attribute.value.atType}._title',
      fields: fields,
    );
  }
}
