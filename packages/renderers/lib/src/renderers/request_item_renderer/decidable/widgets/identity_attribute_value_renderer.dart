import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../../../../renderers.dart';
import '../../../widgets/complex_attribute_list_tile.dart';
import '../../../widgets/custom_list_tile.dart';

class IdentityAttributeValueRenderer extends StatelessWidget {
  final IdentityAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const IdentityAttributeValueRenderer({super.key, required this.value, required this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = value.toJson();

    if (attributeValueMap.length == 2) {
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${value.atType}',
        description: attributeValueMap['value'].toString(),
        trailing: IconButton(onPressed: onEdit, icon: const Icon(Icons.chevron_right)),
      );
    }

    final List<({String label, String value})> fields = attributeValueMap.entries
        .where((e) => e.key != '@type')
        .map((e) => (label: 'i18n://attributes.values.${value.atType}.${e.key}.label', value: e.value.toString()))
        .toList();

    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.${value.atType}._title',
      fields: fields,
      trailing: IconButton(onPressed: onEdit, icon: const Icon(Icons.chevron_right)),
    );
  }
}
