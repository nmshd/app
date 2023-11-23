import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../widgets/complex_attribute_list_tile.dart';
import '../../widgets/custom_list_tile.dart';
import '/src/url_launcher.dart';

class DraftAttributeRenderer extends StatelessWidget {
  final dynamic draftAttribute;
  final Function(bool?)? onUpdateCheckbox;
  final bool? isChecked;
  final bool? hideCheckbox;
  final AbstractAttribute? selectedAttribute;

  const DraftAttributeRenderer({
    super.key,
    required this.draftAttribute,
    this.onUpdateCheckbox,
    this.isChecked,
    this.hideCheckbox,
    this.selectedAttribute,
  });

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
        onUpdateCheckbox: onUpdateCheckbox,
        isChecked: isChecked,
        hideCheckbox: hideCheckbox,
        selectedAttribute: selectedAttribute,
      );
    }

    if (draftAttribute.content is RelationshipAttribute) {
      final attribute = draftAttribute.content as RelationshipAttribute;
      final attributeValueMap = attribute.value.toJson();
      final newAttribute = selectedAttribute as RelationshipAttribute?;

      return switch (attribute.value) {
        final ConsentAttributeValue consentAttributeValue => CustomListTile(
            title: 'i18n://dvo.attribute.name.${attribute.value.atType}',
            description: consentAttributeValue.consent,
            onUpdateCheckbox: onUpdateCheckbox,
            isChecked: isChecked,
            hideCheckbox: hideCheckbox,
            selectedAttribute: newAttribute?.value.toJson()['value'],
            trailing: consentAttributeValue.link != null
                ? IconButton(
                    onPressed: () async {
                      final url = Uri.parse(consentAttributeValue.link!);
                      final urlLauncher = GetIt.I.get<AbstractUrlLauncher>();

                      if (!await urlLauncher.canLaunchUrl(url)) {
                        GetIt.I.get<Logger>().e('Could not launch $url');
                        return;
                      }
                      try {
                        await urlLauncher.launchUrl(url);
                      } catch (e) {
                        GetIt.I.get<Logger>().e(e);
                      }
                    },
                    icon: const Icon(Icons.open_in_new),
                  )
                : null,
          ),
        final ProprietaryJSONAttributeValue proprietaryJSONAttributeValue => CustomListTile(
            title: proprietaryJSONAttributeValue.title,
            // TODO: render the description of the ProprietaryAttributeValue
            // description: proprietaryJSONAttributeValue.description,
            description: proprietaryJSONAttributeValue.value.toString(),
            onUpdateCheckbox: onUpdateCheckbox,
            isChecked: isChecked,
            hideCheckbox: hideCheckbox,
            selectedAttribute: newAttribute?.value.toJson()['value'],
          ),
        final ProprietaryAttributeValue proprietaryAttributeValue => CustomListTile(
            title: proprietaryAttributeValue.title,
            // TODO: render the description of the ProprietaryAttributeValue
            // description: proprietaryAttributeValue.description,
            description: attributeValueMap['value'].toString(),
            onUpdateCheckbox: onUpdateCheckbox,
            isChecked: isChecked,
            hideCheckbox: hideCheckbox,
            selectedAttribute: newAttribute?.value.toJson()['value'],
          ),
        _ => throw Exception('cannot handle RelationshipAttributeValue: ${attribute.value.runtimeType}'),
      };
    }

    throw Exception('Unknown AbstractAttribute: ${draftAttribute.runtimeType}');
  }
}

class AttributeRenderer extends StatelessWidget {
  final Map<String, dynamic> attributeValueMap;
  final String customTitle;
  final List<({String label, String value})> fields;
  final String complexTitle;
  final Function(bool?)? onUpdateCheckbox;
  final bool? isChecked;
  final bool? hideCheckbox;
  final AbstractAttribute? selectedAttribute;

  const AttributeRenderer({
    super.key,
    required this.attributeValueMap,
    required this.customTitle,
    required this.fields,
    required this.complexTitle,
    this.onUpdateCheckbox,
    this.isChecked,
    this.hideCheckbox,
    this.selectedAttribute,
  });

  @override
  Widget build(BuildContext context) {
    final newAttribute = selectedAttribute as IdentityAttribute?;

    if (attributeValueMap.length == 2) {
      return CustomListTile(
        title: customTitle,
        description: attributeValueMap['value'].toString(),
        onUpdateCheckbox: onUpdateCheckbox,
        isChecked: isChecked,
        hideCheckbox: hideCheckbox,
        selectedAttribute: newAttribute?.value.toJson()['value'],
      );
    }

    return ComplexAttributeListTile(
      title: complexTitle,
      fields: fields,
      onUpdateCheckbox: onUpdateCheckbox,
      isChecked: isChecked,
      hideCheckbox: hideCheckbox,
      selectedAttribute: newAttribute?.value.toJson()['value'],
    );
  }
}
