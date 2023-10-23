import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/identity_attribute_renderer.dart';

import '../../widgets/complex_attribute_list_tile.dart';
import '../../widgets/custom_list_tile.dart';

class DraftRelationshipAttributeRenderer extends StatelessWidget {
  final DraftRelationshipAttributeDVO attribute;

  const DraftRelationshipAttributeRenderer({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.content) {
      final IdentityAttribute attribute => IdentityAttributeRenderer(attribute: attribute),
      final RelationshipAttribute attribute => RelationshipAttributeRenderer(attribute: attribute),
      _ => throw Exception('Unknown AbstractAttribute: ${attribute.content.runtimeType}')
    };
  }
}

class RelationshipAttributeRenderer extends StatelessWidget {
  final RelationshipAttribute attribute;

  const RelationshipAttributeRenderer({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = attribute.value.toJson();

    if (attributeValueMap.length == 2) {
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${attribute.value.atType}',
        description: attributeValueMap['value'].toString(),
      );
    }

    if (attributeValueMap.length == 3) {
      return CustomListTile(
        title: attributeValueMap['title'],
        description: attributeValueMap['value'].toString(),
      );
    }

    final List<({String label, String value})> fields =
        attributeValueMap.entries.where((e) => e.key != '@type').map((e) => (label: e.key, value: e.value.toString())).toList();

    return ComplexAttributeListTile(
      title: 'i18n://dvo.attribute.name.${attribute.value.atType}',
      fields: fields,
    );
  }
}
