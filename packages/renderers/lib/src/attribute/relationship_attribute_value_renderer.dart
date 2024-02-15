import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../abstract_url_launcher.dart';
import '../custom_list_tile.dart';

class RelationshipAttributeValueRenderer extends StatelessWidget {
  final RelationshipAttributeValue value;
  final bool showTitle;
  final TextStyle valueTextStyle;
  // TODO: render trailing
  final Widget? trailing;

  const RelationshipAttributeValueRenderer({
    super.key,
    required this.value,
    this.showTitle = true,
    this.valueTextStyle = const TextStyle(fontSize: 16),
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = value.toJson();

    return switch (value) {
      final ConsentAttributeValue consentAttributeValue => CustomListTile(
          title: 'i18n://dvo.attribute.name.${value.atType}',
          description: consentAttributeValue.consent,
          showTitle: showTitle,
          valueTextStyle: valueTextStyle,
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
          thirdLine: proprietaryJSONAttributeValue.value.toString(),
          showTitle: showTitle,
          valueTextStyle: valueTextStyle,
        ),
      final ProprietaryAttributeValue proprietaryAttributeValue => CustomListTile(
          title: proprietaryAttributeValue.title,
          description: attributeValueMap['value'].toString(),
          showTitle: showTitle,
          valueTextStyle: valueTextStyle,
        ),
      _ => throw Exception('cannot handle RelationshipAttributeValue: ${value.runtimeType}'),
    };
  }
}
