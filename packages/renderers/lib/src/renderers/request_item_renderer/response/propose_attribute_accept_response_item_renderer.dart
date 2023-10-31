import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_list_tile.dart';

class ProposeAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final ProposeAttributeAcceptResponseItemDVO item;

  const ProposeAttributeAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: 'i18n://dvo.attribute.name.${item.attribute.value.atType}',
      description: item.attribute.value.toJson()['value'],
    );
  }
}
