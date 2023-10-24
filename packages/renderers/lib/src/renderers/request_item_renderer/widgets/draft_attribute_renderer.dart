import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/complex_attribute_list_tile.dart';
import '../../widgets/custom_list_tile.dart';

class DraftAttributeRenderer extends StatelessWidget {
  final dynamic draftAttribute;

  const DraftAttributeRenderer({super.key, required this.draftAttribute});

  @override
  Widget build(BuildContext context) {
    if (draftAttribute.content is IdentityAttribute) {
      final attribute = draftAttribute.content as IdentityAttribute;
      final attributeValueMap = attribute.value.toJson();

      final List<({String label, String value})> fields = attributeValueMap.entries
          .where((e) => e.key != '@type')
          .map((e) => (label: 'i18n://attributes.values.${attribute.value.atType}.${e.key}.label', value: e.value.toString()))
          .toList();

      return AttributeRenderer(
        attributeValueMap: attributeValueMap,
        customTitle: 'i18n://dvo.attribute.name.${attribute.value.atType}',
        fields: fields,
        complexTitle: 'i18n://attributes.values.${attribute.value.atType}._title',
      );
    }

    if (draftAttribute.content is RelationshipAttribute) {
      final attribute = draftAttribute.content as RelationshipAttribute;
      final attributeValueMap = attribute.value.toJson();

      final List<({String label, String value})> fields =
          attributeValueMap.entries.where((e) => e.key != '@type').map((e) => (label: e.key, value: e.value.toString())).toList();

      return AttributeRenderer(
        attributeValueMap: attributeValueMap,
        customTitle: 'i18n://dvo.attribute.name.${attribute.value.atType}',
        fields: fields,
        complexTitle: 'i18n://dvo.attribute.name.${attribute.value.atType}',
      );
    } else {
      throw Exception('Unknown AbstractAttribute: ${draftAttribute.runtimeType}');
    }
  }
}

class AttributeRenderer extends StatelessWidget {
  final Map<String, dynamic> attributeValueMap;
  final String customTitle;
  final List<({String label, String value})> fields;
  final String complexTitle;

  const AttributeRenderer({
    super.key,
    required this.attributeValueMap,
    required this.customTitle,
    required this.fields,
    required this.complexTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (attributeValueMap.length == 2) {
      return CustomListTile(
        title: customTitle,
        description: attributeValueMap['value'].toString(),
      );
    }

    if (attributeValueMap.length == 3) {
      return CustomListTile(
        title: attributeValueMap['title'],
        description: attributeValueMap['value'].toString(),
      );
    }

    return ComplexAttributeListTile(
      title: complexTitle,
      fields: fields,
    );
  }
}
