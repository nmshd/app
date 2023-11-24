import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../../../renderers.dart';
import '../../widgets/custom_list_tile.dart';

class RelationshipAttributeValueRenderer extends StatelessWidget {
  final RelationshipAttributeValue value;
  final bool? isRejected;

  const RelationshipAttributeValueRenderer({
    super.key,
    required this.value,
    this.isRejected,
  });

  @override
  Widget build(BuildContext context) {
    final attributeValueMap = value.toJson();

    return switch (value) {
      final ConsentAttributeValue consentAttributeValue => CustomListTile(
          title: 'i18n://dvo.attribute.name.${value.atType}',
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
      final ProprietaryJSONAttributeValue proprietaryJSONAttributeValue => CustomListTile(
          title: proprietaryJSONAttributeValue.title,
          // TODO: render the description of the ProprietaryAttributeValue
          // description: proprietaryJSONAttributeValue.description,
          description: proprietaryJSONAttributeValue.value.toString(),
        ),
      final ProprietaryAttributeValue proprietaryAttributeValue => CustomListTile(
          title: proprietaryAttributeValue.title,
          description: isRejected != null && isRejected == true ? null : attributeValueMap['value'].toString(),
        ),
      _ => throw Exception('cannot handle RelationshipAttributeValue: ${value.runtimeType}'),
    };
  }
}
