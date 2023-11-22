import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../widgets/complex_attribute_list_tile.dart';
import '../../widgets/custom_list_tile.dart';
import '/src/url_launcher.dart';

class DraftAttributeRenderer extends StatelessWidget {
  final DraftAttributeDVO draftAttribute;
  final bool? isRejected;

  const DraftAttributeRenderer({super.key, required this.draftAttribute, this.isRejected});

  @override
  Widget build(BuildContext context) {
    final attributeContent = switch (draftAttribute) {
      final DraftIdentityAttributeDVO item => item.content,
      final DraftRelationshipAttributeDVO item => item.content,
    };

    if (attributeContent is IdentityAttribute) {
      final attribute = attributeContent;
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

    if (attributeContent is RelationshipAttribute) {
      final attribute = attributeContent;
      final attributeValueMap = attribute.value.toJson();

      return switch (attribute.value) {
        final ConsentAttributeValue consentAttributeValue => CustomListTile(
            title: 'i18n://dvo.attribute.name.${attribute.value.atType}',
            description: consentAttributeValue.consent,
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
        final ProprietaryAttributeValue proprietaryAttributeValue => CustomListTile(
            title: proprietaryAttributeValue.title,
            description: isRejected != null && isRejected == true ? null : attributeValueMap['value'].toString(),
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
  final bool? isRejected;

  const AttributeRenderer({
    super.key,
    required this.attributeValueMap,
    required this.customTitle,
    required this.fields,
    required this.complexTitle,
    this.isRejected,
  });

  @override
  Widget build(BuildContext context) {
    if (attributeValueMap.containsKey('value') && attributeValueMap.length == 2) {
      return CustomListTile(
        title: customTitle,
        description: isRejected != null && isRejected == true ? null : attributeValueMap['value'].toString(),
      );
    }

    return ComplexAttributeListTile(
      title: complexTitle,
      fields: fields,
    );
  }
}
