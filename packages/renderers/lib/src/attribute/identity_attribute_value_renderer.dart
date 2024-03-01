import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../custom_list_tile.dart';
import 'complex_attribute_list_tile.dart';
import 'value_hint_translation.dart';
import 'widgets/delivery_box_address_attribute_renderer.dart';
import 'widgets/post_office_address_attribute_renderer.dart';
import 'widgets/street_address_attribute_renderer.dart';

class IdentityAttributeValueRenderer extends StatelessWidget {
  final IdentityAttributeValue value;
  final ValueHints valueHints;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? trailing;

  const IdentityAttributeValueRenderer({
    super.key,
    required this.value,
    required this.valueHints,
    this.showTitle = true,
    this.valueTextStyle = const TextStyle(fontSize: 16),
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = value.toJson();

    if (value is StreetAddressAttributeValue) {
      final streetAddress = value as StreetAddressAttributeValue;
      return StreetAddressAttributeRenderer(
        value: streetAddress,
        valueHints: valueHints,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
      );
    }

    if (value is DeliveryBoxAddressAttributeValue) {
      final deliveryAddress = value as DeliveryBoxAddressAttributeValue;
      return DeliveryBoxAddressAttributeRenderer(
        value: deliveryAddress,
        valueHints: valueHints,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
      );
    }

    if (value is PostOfficeBoxAddressAttributeValue) {
      final postOfficeAddress = value as PostOfficeBoxAddressAttributeValue;
      return PostOfficeBoxAddressAttributeRenderer(
        value: postOfficeAddress,
        valueHints: valueHints,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
      );
    }

    if (value is BirthDateAttributeValue) {
      final birthDate = value as BirthDateAttributeValue;
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${value.atType}',
        description: DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(DateTime(birthDate.year, birthDate.month, birthDate.day)),
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
      );
    }

    if (attributeValueMap.containsKey('value') && attributeValueMap.length == 2) {
      return CustomListTile(
        title: 'i18n://dvo.attribute.name.${value.atType}',
        description: valueHints.getTranslation(attributeValueMap['value'].toString()),
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
      );
    }

    final List<({String label, String key, String value})> fields = attributeValueMap.entries
        .where((e) => e.key != '@type')
        .map((e) => (
              label: 'i18n://attributes.values.${value.atType}.${e.key}.label',
              key: e.key,
              value: e.value.toString(),
            ))
        .toList();

    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.${value.atType}._title',
      fields: fields,
      valueHints: valueHints,
      showTitle: showTitle,
      valueTextStyle: valueTextStyle,
      trailing: trailing,
    );
  }
}
