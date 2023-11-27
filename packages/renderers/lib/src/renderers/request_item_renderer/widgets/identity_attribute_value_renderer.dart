import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/complex_attribute_list_tile.dart';
import '../../widgets/custom_list_tile.dart';

class IdentityAttributeValueRenderer extends StatelessWidget {
  final IdentityAttributeValue value;
  final VoidCallback? onEdit;
  final bool? isRejected;
  final Function(bool?)? onUpdateCheckbox;
  final bool? isChecked;
  final bool? hideCheckbox;
  final AbstractAttribute? selectedAttribute;

  const IdentityAttributeValueRenderer({
    super.key,
    required this.value,
    this.onEdit,
    this.isRejected,
    this.onUpdateCheckbox,
    this.isChecked,
    this.hideCheckbox,
    this.selectedAttribute,
  });

  @override
  Widget build(BuildContext context) {
    final newAttribute = selectedAttribute != null ? selectedAttribute as IdentityAttribute : null;
    final attributeValueMap = newAttribute != null ? newAttribute.value.toJson() : value.toJson();

    if (attributeValueMap.containsKey('value') && attributeValueMap.length == 2) {
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${value.atType}',
        description: attributeValueMap['value'].toString(),
        trailing: IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, color: Colors.blue)),
        isChecked: isChecked,
        onUpdateCheckbox: onUpdateCheckbox,
        hideCheckbox: hideCheckbox,
        selectedAttribute: newAttribute != null ? newAttribute.value.toJson()['value'] : null,
      );
    }

    final List<({String label, String value})> fields = attributeValueMap.entries
        .where((e) => e.key != '@type')
        .map((e) => (label: 'i18n://attributes.values.${value.atType}.${e.key}.label', value: e.value.toString()))
        .toList();

    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.${value.atType}._title',
      fields: fields,
      trailing: IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, color: Colors.blue)),
      isChecked: isChecked,
      onUpdateCheckbox: onUpdateCheckbox,
      hideCheckbox: hideCheckbox,
    );
  }
}
