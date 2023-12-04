import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/complex_attribute_list_tile.dart';
import '../../widgets/custom_list_tile.dart';

class IdentityAttributeValueRenderer extends StatelessWidget {
  final IdentityAttributeValue value;
  final Function(bool?)? onUpdateCheckbox;
  final bool? isChecked;
  final bool? hideCheckbox;
  final bool? isRejected;
  final IdentityAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;

  const IdentityAttributeValueRenderer({
    super.key,
    required this.value,
    this.isRejected,
    this.onUpdateCheckbox,
    this.isChecked,
    this.hideCheckbox,
    this.selectedAttribute,
    this.onUpdateAttribute,
  });

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = selectedAttribute != null ? selectedAttribute!.value.toJson() : value.toJson();

    if (attributeValueMap.containsKey('value') && attributeValueMap.length == 2) {
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${value.atType}',
        description: isRejected ?? false ? null : attributeValueMap['value'].toString(),
        isChecked: isChecked,
        onUpdateCheckbox: onUpdateCheckbox,
        hideCheckbox: hideCheckbox,
        onUpdateAttribute: onUpdateAttribute,
        valueType: value.atType,
      );
    }

    final List<({String label, String value})> fields = attributeValueMap.entries
        .where((e) => e.key != '@type')
        .map((e) => (label: 'i18n://attributes.values.${value.atType}.${e.key}.label', value: e.value.toString()))
        .toList();

    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.${value.atType}._title',
      fields: fields,
      isChecked: isChecked,
      onUpdateCheckbox: onUpdateCheckbox,
      hideCheckbox: hideCheckbox,
      onUpdateAttribute: onUpdateAttribute,
      valueType: value.atType,
    );
  }
}
