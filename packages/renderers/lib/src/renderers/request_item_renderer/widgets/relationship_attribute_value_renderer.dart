import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../abstract_url_launcher.dart';
import '../../widgets/custom_list_tile.dart';

class RelationshipAttributeValueRenderer extends StatelessWidget {
  final RelationshipAttributeValue value;
  final bool? isRejected;
  final RelationshipAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;

  const RelationshipAttributeValueRenderer({
    super.key,
    required this.value,
    this.isRejected,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.checkboxSettings,
  });

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = selectedAttribute != null ? selectedAttribute!.value.toJson() : value.toJson();

    return switch (value) {
      final ConsentAttributeValue consentAttributeValue => CustomListTile(
          title: 'i18n://dvo.attribute.name.${value.atType}',
          description: isRejected ?? false ? null : consentAttributeValue.consent,
          checkboxSettings: checkboxSettings,
          trailing: consentAttributeValue.link != null
              ? IconButton(
                  onPressed: () async {
                    final url = Uri.parse(consentAttributeValue.link!);
                    await GetIt.I.get<AbstractUrlLauncher>().launchSafe(url);
                  },
                  icon: const Icon(Icons.open_in_new),
                )
              : null,
        ),
      final ProprietaryJSONAttributeValue proprietaryJSONAttributeValue => CustomListTile(
          title: proprietaryJSONAttributeValue.title,
          description: proprietaryJSONAttributeValue.description,
          thirdLine:
              isRejected ?? false ? null : selectedAttribute?.value.toJson()['value'].toString() ?? proprietaryJSONAttributeValue.value.toString(),
          checkboxSettings: checkboxSettings,
        ),
      final ProprietaryAttributeValue proprietaryAttributeValue => CustomListTile(
          title: proprietaryAttributeValue.title,
          description: isRejected ?? false ? null : attributeValueMap['value'].toString(),
          checkboxSettings: checkboxSettings,
        ),
      _ => throw Exception('cannot handle RelationshipAttributeValue: ${value.runtimeType}'),
    };
  }
}
