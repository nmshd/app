import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/src/attribute/widgets/street_address_attribute_renderer.dart';

import '../custom_list_tile.dart';
import 'complex_attribute_list_tile.dart';

class IdentityAttributeValueRenderer extends StatelessWidget {
  final IdentityAttributeValue value;
  final ValueHints? valueHints;
  final Future<void> Function(String valueType)? onUpdateAttribute;

  const IdentityAttributeValueRenderer({
    super.key,
    required this.value,
    this.valueHints,
    this.onUpdateAttribute,
  });

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = value.toJson();

    if (value is BirthDateAttributeValue) {
      final birthDate = value as BirthDateAttributeValue;
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${value.atType}',
        description: DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(DateTime(birthDate.year, birthDate.month, birthDate.day)),
        trailing: onUpdateAttribute == null
            ? null
            : IconButton(
                onPressed: () => onUpdateAttribute!(value.atType),
                icon: const Icon(Icons.chevron_right),
              ),
      );
    }

    if (attributeValueMap.containsKey('value') && attributeValueMap.length == 2) {
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${value.atType}',
        description: _getValueHintsTranslation(attributeValueMap['value'].toString(), valueHints!),
        trailing: onUpdateAttribute == null
            ? null
            : IconButton(
                onPressed: () => onUpdateAttribute!(value.atType),
                icon: const Icon(Icons.chevron_right),
              ),
      );
    }

    final List<({String label, String value})> fields = attributeValueMap.entries
        .where((e) => e.key != '@type')
        .map((e) => (label: 'i18n://attributes.values.${value.atType}.${e.key}.label', value: e.value.toString()))
        .toList();

    if (value is StreetAddressAttributeValue) {
      final streetAddress = value as StreetAddressAttributeValue;
      return StreetAddressAttributeRenderer(
        value: streetAddress,
        valueHints: valueHints,
      );
    }

    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.${value.atType}._title',
      fields: fields,
      valueHints: valueHints,
      onUpdateAttribute: onUpdateAttribute,
      valueType: value.atType,
    );
  }

  String _getValueHintsTranslation(value, ValueHints valueHints) {
    if (valueHints.values == null) {
      return value;
    } else {
      try {
        final valueHint = valueHints.values!.firstWhere((valueHint) => valueHint.key.toJson() == value);
        return valueHint.displayName;
      } on StateError {
        // no matching valueHint found
        return value;
      }
    }
  }
}
