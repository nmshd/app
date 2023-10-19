import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../../../../renderers.dart';
import '../../../widgets/complex_attribute_list_tile.dart';
import '../../../widgets/custom_list_tile.dart';

class IdentityAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final IdentityAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const IdentityAttributeValueRenderer({super.key, required this.value, required this.query, required this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = value.toJson();

    String title = 'i18n://dvo.attribute.name.${attributeValueMap['@type']}';
    if (attributeValueMap.length > 2) {
      title = 'i18n://attributes.values.${attributeValueMap['@type']}._title';
    }

    if (attributeValueMap.length == 2) {
      final value = attributeValueMap.entries.firstWhere((e) => e.key != '@type').value.toString();
      return CustomListTile(
        title: title,
        value: value,
        trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
      );
    }

    final typeValue = attributeValueMap['@type'];
    final List<String> labels = [];
    final List<String> values = [];

    attributeValueMap.forEach((key, value) {
      if (key != '@type') {
        labels.add('i18n://attributes.values.$typeValue.$key.label');
        values.add(value.toString());
      }
    });

    return ComplexAttributeListTile(
      title: title,
      labels: labels,
      values: values,
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}
