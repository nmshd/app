import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_list_tile.dart';

class ReadAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final ReadAttributeAcceptResponseItemDVO item;

  const ReadAttributeAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: 'i18n://dvo.attribute.name.${item.attribute.value.atType}',
      description: item.attribute.value.toJson()['value'],
    );
  }
}
